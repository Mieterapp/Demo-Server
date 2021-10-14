import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


def check_mail_requirements():
    server = smtplib.SMTP("smtp.office365.com")
    server.connect("smtp.office365.com", 587)
    server.ehlo()
    server.starttls()
    server.ehlo()
    server.login("mieterapp@gwg-gruppe.de", "Stuttgart21!")
    msg = MIMEMultipart()
    msg["From"] = "mieterapp@gwg-gruppe.de"
    msg["To"] = "philipp.litzenberger@dit-digital.de"
    msg["Subject"] = "Test Email"
    message = "Test message content"
    msg.attach(MIMEText(message, "text"))

    server.send_message(msg)


if __name__ == "__main__":
    check_mail_requirements()