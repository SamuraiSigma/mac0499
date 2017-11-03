#ifndef SUMATOR_H
#define SUMATOR_H

#include "node.h"

class Sumator : public Node {
    OBJ_TYPE(Sumator, Node);
    int count;

protected:
    static void _bind_methods();

public:
    void add(int value);
    void reset();
    int get_total() const;

    Sumator();
};

#endif
