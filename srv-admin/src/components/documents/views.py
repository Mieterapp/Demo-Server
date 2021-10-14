from src.components.docu_web.helper.all_documents import get_all_documents, get_all_documents_contracts
from django.http.response import FileResponse
from src.components.docu_web.documents.get_documents import get_document_file
from rest_framework import viewsets, mixins
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.decorators import api_view

# Create your views here.

# /api/v1/documents
# [{id, href, name, type: contract | issue | other}]
# issue: SEPA Lastschriftmandat | Mietbescheinigung
# contract: Mietvertrag | Hausordnung
import logging

logger = logging.getLogger(__name__)


class DocumentViewSet(viewsets.ViewSet):
    permission_classes = (IsAuthenticated,)

    def list(self, request):
        user = request.user
        logger.debug(f"normalize_get_indexes to_documents request {str(user)}")
        # user = "10207.0106.06"
        normalized_reponse = get_all_documents(user)
        return Response(normalized_reponse)

    def post(self, request, pk):
        logger.debug(f"normalize_get_indexes to_documents {request.method}")
        if request.method == "POST":
            user = request.user

            new_partnerid = pk.replace("A", ".")

            logger.debug(f"normalize_get_indexes to_documents {user}")
            logger.debug(f"normalize_get_indexes to_documents {pk}")
            # user = "10207.0106.06"
            normalized_reponse = get_all_documents_contracts(user, new_partnerid)
            logger.debug(f"normalize_get_indexes to_documents normalized_reponse extra {normalized_reponse}")
            return Response(normalized_reponse)
        if request.method == "GET":
            user = request.user
            logger.debug(f"POST_indexes to_documents {user}")
            logger.debug(f"POST_get_indexes to_documents {pk}")
            return Response(["Test DAta"])
            '''
    def retrieve(self, request, pk):
        logger.debug(f"normalize_get_indexes to_documents {request.method}")
        if request.method=="GET":
            user = request.user

            new_partnerid = pk.replace("A", ".")

            logger.debug(f"normalize_get_indexes to_documents {user}")
            logger.debug(f"normalize_get_indexes to_documents {pk}")
            #user = "10207.0106.06"
            normalized_reponse = get_all_documents_contracts(user, new_partnerid)
            logger.debug(f"normalize_get_indexes to_documents normalized_reponse extra {normalized_reponse}")
            return Response(normalized_reponse)
    '''

    def retrieve(self, request, pk):
        logger.debug(f"normalize_get_indexes to_documents {request.method}")
        if request.method == "GET":
            d_type = request.GET.get("type")
            return FileResponse(
                get_document_file(d_type, pk), content_type="application/pdf"
            )


class DocumentwithContractViewSet(mixins.RetrieveModelMixin, mixins.CreateModelMixin, mixins.ListModelMixin,
                                  viewsets.GenericViewSet):
    permission_classes = (IsAuthenticated,)

    def post(self, request, pk):
        logger.debug(f"normalize_get_indexes to_documents {request.method}")
        if request.method == "GET":
            user = request.user

            new_partnerid = pk.replace("A", ".")

            logger.debug(f"normalize_get_indexes to_documents {user}")
            logger.debug(f"normalize_get_indexes to_documents {new_partnerid}")
            # user = "10207.0106.06"
            normalized_reponse = get_all_documents_contracts(user, new_partnerid)
            logger.debug(f"normalize_get_indexes to_documents normalized_reponse extra ENDE {normalized_reponse}")
            return Response(normalized_reponse)
        if request.method == "POST":
            user = request.user
            logger.debug(f"POST_indexes to_documents {user}")
            logger.debug(f"POST_get_indexes to_documents {pk}")
            return Response(["Test DAta"])

    # @api_view(['GET', 'PUT'])
    '''
    def retrieve(self, request, pk):
        logger.debug(f"normalize_get_indexes to_documents {request.method}")
        if request.method=="GET":
            d_type = request.GET.get("type")
            return FileResponse(
                get_document_file(d_type, pk), content_type="application/pdf"
            )
    '''

    def retrieve(self, request, pk):
        logger.debug(f"normalize_get_indexes to_documents {request.method}")
        if request.method == "GET":
            user = request.user

            new_partnerid = pk.replace("A", ".")

            logger.debug(f"normalize_get_indexes to_documents {user}")
            logger.debug(f"normalize_get_indexes to_documents {pk}")
            # user = "10207.0106.06"
            normalized_reponse = get_all_documents_contracts(user, new_partnerid)
            logger.debug(f"normalize_get_indexes to_documents normalized_reponse extra {normalized_reponse}")
            return Response(normalized_reponse)
        if request.method == "POST":
            user = request.user
            logger.debug(f"POST_indexes to_documents {user}")
            logger.debug(f"POST_get_indexes to_documents {pk}")
