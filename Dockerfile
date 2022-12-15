FROM python:3-slim AS base

FROM base AS builder

WORKDIR /usr/src/app
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH=$VIRTUAL_ENV/bin:$PATH
RUN pip install --no-cache-dir pip-tools
COPY requirements.in .
RUN pip-compile --pip-args "--no-cache-dir"
RUN pip-sync

FROM base AS runtime
COPY --from=builder /opt/venv /opt/venv
RUN adduser --disabled-password appuser

USER appuser
WORKDIR /home/appuser

COPY update-route53.yaml .
ENV VIRTUAL_ENV=/opt/venv
ENV PATH=$VIRTUAL_ENV/bin:$PATH
ENV ANSIBLE_LOCALHOST_WARNING=false

CMD ["ansible-playbook", "update-route53.yaml"]