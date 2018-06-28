

#ifndef PORT_H
#define PORT_H


#include "trema.h"


typedef struct port_info {
  uint64_t dpid;
  uint16_t port_no;
  bool external_link;
  bool switch_to_switch_link;
  bool switch_to_switch_reverse_link;
} port_info;


typedef struct switch_info {
  uint64_t dpid;
  list_element *ports; // list of port_info
} switch_info;


void delete_port( list_element **switches, port_info *delete_port );
void add_port( list_element **switches, uint64_t dpid, uint16_t port_no, uint8_t external );
void update_port( port_info *port, uint8_t external );
void delete_all_ports( list_element **switches );
port_info *lookup_port( list_element *switches, uint64_t dpid, uint16_t port_no );
int foreach_port( const list_element *ports,
                  int ( *function )( port_info *port,
                                     openflow_actions *actions,
                                     uint64_t dpid, uint16_t in_port ),
                  openflow_actions *actions, uint64_t dpid, uint16_t port );
void foreach_switch( const list_element *switches,
                     void ( *function )( switch_info *sw,
                                         const buffer *packet,
                                         uint64_t dpid,
                                         uint16_t in_port ),
                     const buffer *packet, uint64_t dpid, uint16_t in_port );
list_element *create_ports( list_element **switches );


#endif // PORT_H


