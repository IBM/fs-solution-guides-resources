FROM registry.access.redhat.com/ubi9/ubi-minimal


# Install required tools
RUN microdnf install -y \
    tar \
    gzip \
    ca-certificates \
    shadow-utils \
    && microdnf clean all

# Download oc-mirror (amd64 ONLY)
RUN curl -L \
  https://mirror.openshift.com/pub/openshift-v5/amd64/clients/ocp/4.20.10/oc-mirror.rhel9.tar.gz \
  -o /tmp/oc-mirror.tar.gz \
  && tar -xzf /tmp/oc-mirror.tar.gz -C /tmp \
  && mv /tmp/oc-mirror /usr/local/bin/oc-mirror \
  && chmod +x /usr/local/bin/oc-mirror \
  && rm -f /tmp/oc-mirror.tar.gz

# Verify binary exists
RUN oc-mirror version

WORKDIR /workspace