import React from "react";
import styles from "./styles.module.css";
interface ProfileCardProps extends React.ComponentProps<"div">{
    name: string;
    year: string;
    homeState: string;
}
// export default function ProfileCard(props: ProfileCardProps) {
export default function ProfileCard({
    name, 
    year,
    homeState,
    ...props
}:ProfileCardProps){
    return(
        <div {...props} className={styles.container}>
            <p> Hi! my name is {name}. 
            I am a {year} year CS student at GT from {homeState}
            </p>
        </div>
    );
}