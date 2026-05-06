-- 1. Enums initialization
CREATE TYPE appointment_status AS ENUM ('pendiente', 'confirmada', 'completada', 'cancelada');

-- 2. Tables creation
CREATE TABLE public.pacientes (
    id UUID REFERENCES auth.users NOT NULL PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellidos TEXT NOT NULL,
    cedula TEXT UNIQUE NOT NULL,
    telefono TEXT,
    ars_nombre TEXT,
    numero_afiliado TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE public.citas (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    paciente_id UUID REFERENCES public.pacientes(id) ON DELETE CASCADE NOT NULL,
    fecha_hora_inicio TIMESTAMPTZ NOT NULL,
    estado appointment_status DEFAULT 'pendiente' NOT NULL,
    motivo_consulta TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE public.resultados_medicos (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    paciente_id UUID REFERENCES public.pacientes(id) ON DELETE CASCADE NOT NULL,
    titulo_analisis TEXT NOT NULL,
    ruta_archivo_storage TEXT NOT NULL,
    observaciones TEXT,
    fecha_subida TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Row Level Security (RLS) Configuration
ALTER TABLE public.pacientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.citas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.resultados_medicos ENABLE ROW LEVEL SECURITY;

-- 4. Policies for 'pacientes'
CREATE POLICY "Pacientes pueden ver su propio perfil" 
ON public.pacientes FOR SELECT 
USING (auth.uid() = id);

CREATE POLICY "Pacientes pueden insertar su propio perfil" 
ON public.pacientes FOR INSERT 
WITH CHECK (auth.uid() = id);

CREATE POLICY "Pacientes pueden actualizar su propio perfil" 
ON public.pacientes FOR UPDATE 
USING (auth.uid() = id);

-- 5. Policies for 'citas'
CREATE POLICY "Pacientes pueden ver sus propias citas" 
ON public.citas FOR SELECT 
USING (auth.uid() = paciente_id);

-- 6. Policies for 'resultados_medicos'
CREATE POLICY "Pacientes pueden ver sus propios resultados" 
ON public.resultados_medicos FOR SELECT 
USING (auth.uid() = paciente_id);

-- 7. Grant access to authenticated users
GRANT ALL ON TABLE public.pacientes TO authenticated;
GRANT ALL ON TABLE public.citas TO authenticated;
GRANT ALL ON TABLE public.resultados_medicos TO authenticated;
