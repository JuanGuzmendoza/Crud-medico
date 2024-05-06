import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PacientesModule } from './pacientes/pacientes.module';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: 'localhost',
      port: 3306,
      username: 'root',
      password: '',
      database: 'citas',
      entities: [
        __dirname + '/**/**/*.entity{.ts,.js}', // cargar las entidades
      ],
      autoLoadEntities: true,
      synchronize: true,
    }),
    PacientesModule 
  ],

  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
