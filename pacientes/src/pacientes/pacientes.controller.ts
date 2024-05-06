import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UsePipes, ValidationPipe } from '@nestjs/common';
import { PacientesService } from './pacientes.service';
import { CreatePacienteDto } from './dto/create-paciente.dto';
import { UpdatePacienteDto } from './dto/update-paciente.dto';
@UsePipes(new ValidationPipe())
@Controller('pacientes')
export class PacientesController {
  constructor(private readonly pacientesService: PacientesService) {}
  @Post()
  async create(@Body() createPacienteDto: CreatePacienteDto) {
    try {
      const createdPaciente = await this.pacientesService.create(createPacienteDto);
      return { success: true, data: createdPaciente };
    } catch (error) {
      return { success: false, message: 'Error al crear el pacientee', error };
    }
  }

  @Get()
  findAll(@Query() query: string) {
    console.log(query);
    return this.pacientesService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.pacientesService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updatePacienteDto: UpdatePacienteDto) {
    return this.pacientesService.update(+id, updatePacienteDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.pacientesService.remove(+id);
  }
}
