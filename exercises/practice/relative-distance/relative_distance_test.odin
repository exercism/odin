package relative_distance

import "core:testing"

@(test)
/// description = Direct parent-child relation
test_direct_parent_child_relation :: proc(t: ^testing.T) {

	family: FamilyTree
	defer delete(family)
	family["Vera"] = Children{"Tomoko"}
	family["Tomoko"] = Children{"Aditi"}

	result := degree_of_separation(family, "Vera", "Tomoko")
	testing.expect_value(t, result, 1)
}

@(test)
/// description = Sibling relationship
test_sibling_relationship :: proc(t: ^testing.T) {

	family: FamilyTree
	defer delete(family)
	family["Dalia"] = Children{"Olga", "Yassin"}

	result := degree_of_separation(family, "Olga", "Yassin")
	testing.expect_value(t, result, 1)
}

@(test)
/// description = Two degrees of separation, grandchild
test_two_degrees_of_separation_grandchild :: proc(t: ^testing.T) {

	family: FamilyTree
	defer delete(family)
	family["Khadija"] = Children{"Mateo"}
	family["Mateo"] = Children{"Rami"}

	result := degree_of_separation(family, "Khadija", "Rami")
	testing.expect_value(t, result, 2)
}

@(test)
/// description = Unrelated individuals
test_unrelated_individuals :: proc(t: ^testing.T) {

	family: FamilyTree
	defer delete(family)
	family["Priya"] = Children{"Rami"}
	family["Kaito"] = Children{"Elif"}

	result := degree_of_separation(family, "Priya", "Kaito")
	testing.expect_value(t, result, -1)
}

@(test)
/// description = Complex graph, cousins
test_complex_graph_cousins :: proc(t: ^testing.T) {

	family: FamilyTree
	defer delete(family)
	family["Aiko"] = Children{"Bao", "Carlos"}
	family["Bao"] = Children{"Dalia", "Elias"}
	family["Carlos"] = Children{"Fatima", "Gustavo"}
	family["Dalia"] = Children{"Hassan", "Isla"}
	family["Elias"] = Children{"Javier"}
	family["Fatima"] = Children{"Khadija", "Liam"}
	family["Gustavo"] = Children{"Mina"}
	family["Hassan"] = Children{"Noah", "Olga"}
	family["Isla"] = Children{"Pedro"}
	family["Javier"] = Children{"Quynh", "Ravi"}
	family["Khadija"] = Children{"Sofia"}
	family["Liam"] = Children{"Tariq", "Uma"}
	family["Mina"] = Children{"Viktor", "Wang"}
	family["Noah"] = Children{"Xiomara"}
	family["Olga"] = Children{"Yuki"}
	family["Pedro"] = Children{"Zane", "Aditi"}
	family["Quynh"] = Children{"Boris"}
	family["Ravi"] = Children{"Celine"}
	family["Sofia"] = Children{"Diego", "Elif"}
	family["Tariq"] = Children{"Farah"}
	family["Uma"] = Children{"Giorgio"}
	family["Viktor"] = Children{"Hana", "Ian"}
	family["Wang"] = Children{"Jing"}
	family["Xiomara"] = Children{"Kaito"}
	family["Yuki"] = Children{"Leila"}
	family["Zane"] = Children{"Mateo"}
	family["Aditi"] = Children{"Nia"}
	family["Boris"] = Children{"Oscar"}
	family["Celine"] = Children{"Priya"}
	family["Diego"] = Children{"Qi"}
	family["Elif"] = Children{"Rami"}
	family["Farah"] = Children{"Sven"}
	family["Giorgio"] = Children{"Tomoko"}
	family["Hana"] = Children{"Umar"}
	family["Ian"] = Children{"Vera"}
	family["Jing"] = Children{"Wyatt"}
	family["Kaito"] = Children{"Xia"}
	family["Leila"] = Children{"Yassin"}
	family["Mateo"] = Children{"Zara"}
	family["Nia"] = Children{"Antonio"}
	family["Oscar"] = Children{"Bianca"}
	family["Priya"] = Children{"Cai"}
	family["Qi"] = Children{"Dimitri"}
	family["Rami"] = Children{"Ewa"}
	family["Sven"] = Children{"Fabio"}
	family["Tomoko"] = Children{"Gabriela"}
	family["Umar"] = Children{"Helena"}
	family["Vera"] = Children{"Igor"}
	family["Wyatt"] = Children{"Jun"}
	family["Xia"] = Children{"Kim"}
	family["Yassin"] = Children{"Lucia"}
	family["Zara"] = Children{"Mohammed"}

	result := degree_of_separation(family, "Dimitri", "Fabio")
	testing.expect_value(t, result, 9)
}

@(test)
/// description = Complex graph, no shortcut, far removed nephew
test_complex_graph_no_shortcut_far_removed_nephew :: proc(t: ^testing.T) {

	family: FamilyTree
	defer delete(family)
	family["Aiko"] = Children{"Bao", "Carlos"}
	family["Bao"] = Children{"Dalia", "Elias"}
	family["Carlos"] = Children{"Fatima", "Gustavo"}
	family["Dalia"] = Children{"Hassan", "Isla"}
	family["Elias"] = Children{"Javier"}
	family["Fatima"] = Children{"Khadija", "Liam"}
	family["Gustavo"] = Children{"Mina"}
	family["Hassan"] = Children{"Noah", "Olga"}
	family["Isla"] = Children{"Pedro"}
	family["Javier"] = Children{"Quynh", "Ravi"}
	family["Khadija"] = Children{"Sofia"}
	family["Liam"] = Children{"Tariq", "Uma"}
	family["Mina"] = Children{"Viktor", "Wang"}
	family["Noah"] = Children{"Xiomara"}
	family["Olga"] = Children{"Yuki"}
	family["Pedro"] = Children{"Zane", "Aditi"}
	family["Quynh"] = Children{"Boris"}
	family["Ravi"] = Children{"Celine"}
	family["Sofia"] = Children{"Diego", "Elif"}
	family["Tariq"] = Children{"Farah"}
	family["Uma"] = Children{"Giorgio"}
	family["Viktor"] = Children{"Hana", "Ian"}
	family["Wang"] = Children{"Jing"}
	family["Xiomara"] = Children{"Kaito"}
	family["Yuki"] = Children{"Leila"}
	family["Zane"] = Children{"Mateo"}
	family["Aditi"] = Children{"Nia"}
	family["Boris"] = Children{"Oscar"}
	family["Celine"] = Children{"Priya"}
	family["Diego"] = Children{"Qi"}
	family["Elif"] = Children{"Rami"}
	family["Farah"] = Children{"Sven"}
	family["Giorgio"] = Children{"Tomoko"}
	family["Hana"] = Children{"Umar"}
	family["Ian"] = Children{"Vera"}
	family["Jing"] = Children{"Wyatt"}
	family["Kaito"] = Children{"Xia"}
	family["Leila"] = Children{"Yassin"}
	family["Mateo"] = Children{"Zara"}
	family["Nia"] = Children{"Antonio"}
	family["Oscar"] = Children{"Bianca"}
	family["Priya"] = Children{"Cai"}
	family["Qi"] = Children{"Dimitri"}
	family["Rami"] = Children{"Ewa"}
	family["Sven"] = Children{"Fabio"}
	family["Tomoko"] = Children{"Gabriela"}
	family["Umar"] = Children{"Helena"}
	family["Vera"] = Children{"Igor"}
	family["Wyatt"] = Children{"Jun"}
	family["Xia"] = Children{"Kim"}
	family["Yassin"] = Children{"Lucia"}
	family["Zara"] = Children{"Mohammed"}

	result := degree_of_separation(family, "Lucia", "Jun")
	testing.expect_value(t, result, 14)
}

@(test)
/// description = Complex graph, some shortcuts, cross-down and cross-up, cousins several times removed, with unrelated family tree
test_complex_graph_some_shortcuts_cross_down_and_cross_up_cousins_several_times_removed_with_unrelated_family_tree :: proc(
	t: ^testing.T,
) {

	family: FamilyTree
	defer delete(family)
	family["Aiko"] = Children{"Bao", "Carlos"}
	family["Bao"] = Children{"Dalia"}
	family["Carlos"] = Children{"Fatima", "Gustavo"}
	family["Dalia"] = Children{"Hassan", "Isla"}
	family["Fatima"] = Children{"Khadija", "Liam"}
	family["Gustavo"] = Children{"Mina"}
	family["Hassan"] = Children{"Noah", "Olga"}
	family["Isla"] = Children{"Pedro"}
	family["Javier"] = Children{"Quynh", "Ravi"}
	family["Khadija"] = Children{"Sofia"}
	family["Liam"] = Children{"Tariq", "Uma"}
	family["Mina"] = Children{"Viktor", "Wang"}
	family["Noah"] = Children{"Xiomara"}
	family["Olga"] = Children{"Yuki"}
	family["Pedro"] = Children{"Zane", "Aditi"}
	family["Quynh"] = Children{"Boris"}
	family["Ravi"] = Children{"Celine"}
	family["Sofia"] = Children{"Diego", "Elif"}
	family["Tariq"] = Children{"Farah"}
	family["Uma"] = Children{"Giorgio"}
	family["Viktor"] = Children{"Hana", "Ian"}
	family["Wang"] = Children{"Jing"}
	family["Xiomara"] = Children{"Kaito"}
	family["Yuki"] = Children{"Leila"}
	family["Zane"] = Children{"Mateo"}
	family["Aditi"] = Children{"Nia"}
	family["Boris"] = Children{"Oscar"}
	family["Celine"] = Children{"Priya"}
	family["Diego"] = Children{"Qi"}
	family["Elif"] = Children{"Rami"}
	family["Farah"] = Children{"Sven"}
	family["Giorgio"] = Children{"Tomoko"}
	family["Hana"] = Children{"Umar"}
	family["Ian"] = Children{"Vera"}
	family["Jing"] = Children{"Wyatt"}
	family["Kaito"] = Children{"Xia"}
	family["Leila"] = Children{"Yassin"}
	family["Mateo"] = Children{"Zara"}
	family["Nia"] = Children{"Antonio"}
	family["Oscar"] = Children{"Bianca"}
	family["Priya"] = Children{"Cai"}
	family["Qi"] = Children{"Dimitri"}
	family["Rami"] = Children{"Ewa"}
	family["Sven"] = Children{"Fabio"}
	family["Tomoko"] = Children{"Gabriela"}
	family["Umar"] = Children{"Helena"}
	family["Vera"] = Children{"Igor"}
	family["Wyatt"] = Children{"Jun"}
	family["Xia"] = Children{"Kim"}
	family["Yassin"] = Children{"Lucia"}
	family["Zara"] = Children{"Mohammed"}

	result := degree_of_separation(family, "Wyatt", "Xia")
	testing.expect_value(t, result, 12)
}
