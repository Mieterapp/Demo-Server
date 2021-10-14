from src.components.docu_web.api import api_get, api_get2


def get_documents(d_type: str, collect_id):
    pdf_response = api_get(
        path=f"/api/dokuweb/documents/{d_type}/COLLECTID/{collect_id}"
    )

    return pdf_response


def get_document_file(d_type: str, collect_id):
    pdf_response = api_get2(
        path=f"/api/dokuweb/documents/{d_type}/COLLECTID/{collect_id}", query={}
    )

    return pdf_response
