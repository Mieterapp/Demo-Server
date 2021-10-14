def get_filtered_by_object_id(user, entities):
    contracts = [] if user.is_anonymous else user.contracts.all()
    ids = []
    for e in entities:
        if e.visible_object:
            allowed = e.visible_object.split(";")
            for a in allowed:
                if len(a.strip()) > 0:
                    for contract in contracts:
                        if contract.number.find(a.strip(), 0, len(a.strip())) != -1:
                            ids.append(e.id)
        else:
            ids.append(e.id)

    return ids


def group_reducer(acc, item):
    group = item["group"]
    try:
        acc[group].append(item)
    except:
        acc[group] = [item]
    return acc