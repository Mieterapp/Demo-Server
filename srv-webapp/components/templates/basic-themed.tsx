import React from "react";
import { ThemeProvider, CSSReset, DarkMode } from "@chakra-ui/core";

import theme from "../theme";
import { Container } from "../atoms/container";

export const BasicThemed: React.FC = ({ children }) => {
  return (
    <ThemeProvider theme={theme}>
      <DarkMode>
        <Container>{children}</Container>
      </DarkMode>
      <CSSReset />
    </ThemeProvider>
  );
};
