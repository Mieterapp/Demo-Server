import { NextPageContext } from "next";
import React from "react";
import { BasicThemed } from "../components/templates/basic-themed";
import { VerifyEmail } from "../modules/verify-email";

export async function getServerSideProps(context: NextPageContext) {
  fetch("");
  return {
    props: {}, // will be passed to the page component as props
  };
}

const Index = () => {
  return (
    <BasicThemed>
      <VerifyEmail />
    </BasicThemed>
  );
};

export default Index;
