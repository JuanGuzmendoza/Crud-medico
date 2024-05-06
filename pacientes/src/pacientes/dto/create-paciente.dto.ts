import { IsEmail, IsNotEmpty, IsNumberString } from "class-validator";

export class CreatePacienteDto {
    Nombre_Paciente: string;
    @IsEmail()
    gmail:           string;
    Doctor:          string;
    Tipo_Cita:       string;
}
