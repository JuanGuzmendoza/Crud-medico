import {  Column, CreateDateColumn, Entity, PrimaryGeneratedColumn} from "typeorm";

@Entity()
export class Pacientes {
    @PrimaryGeneratedColumn()
    id:number;
    @Column({type:'varchar', length:50})
    Nombre_Paciente: string;
    @Column()
    gmail:           string;

    @Column()
    Doctor:          string;
        @Column()
    Tipo_Cita:       string;
}
