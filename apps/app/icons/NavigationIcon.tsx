import { IconProps } from "@/types/icons"
import Svg, { Path } from "react-native-svg"

export default function NavigationIcon({ color, size, style }: IconProps): JSX.Element {
  return (
    <Svg width="20" height="20" viewBox="0 0 20 20" fill="none">
      <Path d="M14.19 0H5.81C2.17 0 0 2.17 0 5.81V14.18C0 17.83 2.17 20 5.81 20H14.18C17.82 20 19.99 17.83 19.99 14.19V5.81C20 2.17 17.83 0 14.19 0ZM15.35 7.05L13.01 14.59C12.45 16.38 9.94 16.41 9.35 14.63L8.65 12.56C8.46 11.99 8.01 11.53 7.44 11.35L5.36 10.65C3.6 10.06 3.62 7.53 5.41 6.99L12.95 4.64C14.43 4.19 15.82 5.58 15.35 7.05Z" fill={color} />
    </Svg>
  );
}
