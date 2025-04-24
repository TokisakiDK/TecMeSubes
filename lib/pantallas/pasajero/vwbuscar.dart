import 'package:flutter/material.dart';
import 'package:tec_me_subes/bases/vwbaseviajes.dart';

class VWBuscar extends StatefulWidget {
  const VWBuscar({super.key});

  @override
  State<VWBuscar> createState() => _VWBuscarState();
}

class _VWBuscarState extends State<VWBuscar> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _destinosDisponibles = [
    'Instituto Tecnológico de Pachuca',
    'Plaza Galerías',
    'Fraccionamiento Los Tuzos',
    'Villas de Pachuca',
    'Centro Histórico',
    'Terminal de Autobuses',
    'Plaza Bella'
  ];
  List<String> _resultadosBusqueda = [];
  bool _mostrarResultados = false;

  @override
  void initState() {
    super.initState();
    _resultadosBusqueda = _destinosDisponibles;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _buscarDestinos(String query) {
    setState(() {
      _mostrarResultados = query.isNotEmpty;
      _resultadosBusqueda = _destinosDisponibles
          .where((destino) => destino.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _limpiarBusqueda() {
    setState(() {
      _searchController.clear();
      _mostrarResultados = false;
      _resultadosBusqueda = _destinosDisponibles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VWBaseViajes(
      tituloPantalla: 'Buscar Destino',
      cuerpoPantalla: _buildBody(context),
      indiceInicial: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 30),
              onPressed: () => Navigator.pushReplacementNamed(context, '/inicio-pasajero'),
            ),
          ),
          const SizedBox(height: 10),
          _buildSearchBox(),
          const SizedBox(height: 20),
          _buildQuickLocationPanel(),
          const SizedBox(height: 20),
          _buildResultsPanel(),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: '¿A dónde vas?',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _limpiarBusqueda,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          onChanged: _buscarDestinos,
        ),
        if (_mostrarResultados) ...[
          const SizedBox(height: 8),
          _buildResultsList(),
        ],
      ],
    );
  }

  Widget _buildResultsList() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _resultadosBusqueda.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.location_on, color: Colors.blue),
            title: Text(_resultadosBusqueda[index]),
            onTap: () {
              _searchController.text = _resultadosBusqueda[index];
              setState(() => _mostrarResultados = false);
            },
          );
        },
      ),
    );
  }

  Widget _buildQuickLocationPanel() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.history),
                label: const Text('Última ubicación utilizada'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.bookmark),
                label: const Text('Ubicaciones guardadas'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsPanel() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Viajes disponibles',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                'Selecciona un destino para ver viajes',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}