FROM python:3.7

WORKDIR /pytest

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

#ADD shay /shays
COPY . .

CMD [ "/usr/local/bin/pytest", "-v", "-s" ]
CMD [ "/usr/local/bin/pytest", "-v", "-ss" ]
