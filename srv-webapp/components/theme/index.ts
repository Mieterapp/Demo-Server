import { theme as chakraTheme } from "@chakra-ui/core";
import { ITheme } from "@chakra-ui/core/dist/theme";

type BreakPoints = string[] & {
  sm?: string;
  md?: string;
  lg?: string;
  xl?: string;
};

const breakpoints: BreakPoints = ["30em", "48em", "62em", "80em"];
breakpoints.sm = breakpoints[0];
breakpoints.md = breakpoints[1];
breakpoints.lg = breakpoints[2];
breakpoints.xl = breakpoints[3];

const theme = {
  ...chakraTheme,
  fonts: {
    heading: '"Avenir Next", sans-serif',
    body: "system-ui, sans-serif",
    mono: "Menlo, monospace",
  },
  colors: {
    ...chakraTheme.colors,
    GWGBlue: {
      900: "#2769B2",
    },
  },
  fontSizes: {
    xs: "0.75rem",
    sm: "0.875rem",
    md: "1rem",
    lg: "1.125rem",
    xl: "1.25rem",
    "2xl": "1.5rem",
    "3xl": "1.875rem",
    "4xl": "2.25rem",
    "5xl": "3rem",
    "6xl": "4rem",
  },
};

export type ICustomTheme = ITheme & typeof theme;

export default theme;
