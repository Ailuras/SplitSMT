(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_at_re (String RegLan Int) String)
(declare-fun split_rest_re (String RegLan Int) String)
(declare-fun num_splits_re (String RegLan) Int)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits x d) limit)
         (num_splits x d)
         limit)
    (num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits x d) limit))
    (split_rest x d (- limit 1))
    (split_at x d i)
  )
)

(define-fun get_split_length_re ((x String) (d RegLan) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits_re x d) limit)
         (num_splits_re x d)
         limit)
    (num_splits_re x d)
  )
)

(define-fun get_split_element_re ((x String) (d RegLan) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits_re x d) limit))
    (split_rest_re x d (- limit 1))
    (split_at_re x d i)
  )
)

(declare-sort var1890 0)
(declare-sort var3000 0)
(declare-sort var1690 0)
(declare-sort var218 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun resultsSlot/506553339 (var1890) var1690)
(declare-fun getContent/2060121830 (var1690) var218)
(declare-fun var218_clear/2124191932 (var218) void)
(declare-const null-var1890 var1890)
(declare-const null-String String)
(declare-const var2261 var1890) ; Statement: r0 := @this: org.docx4j.model.fields.FieldRef 
(assert (not (= var2261 null-var1890)))
(declare-const var1401 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1401 null-String)))
(define-const var806 var1690 (resultsSlot/506553339 var2261)) ; Statement: $r1 = r0.<org.docx4j.model.fields.FieldRef: org.docx4j.wml.R resultsSlot> 
(assert true)
(define-const var3496 var218 (getContent/2060121830 var806)) ; Statement: $r2 = virtualinvoke $r1.<org.docx4j.wml.R: java.util.List getContent()>() 
;(assert (var218_clear/2124191932 var3496)) ; Statement: interfaceinvoke $r2.<java.util.List: void clear()>() 

(declare-const var3496!1 var218)
; split operation: var3473 = var1401.split("\u005cR") ; Statement: r4 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\R") 
(define-const var1497 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(define-const var24 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
(define-const var3064 Int (get_split_length_re var1401 (re.union (str.to_re "\u{0D}") (str.to_re "\u{0A}")) (- 1))) ; Statement: $i0 = lengthof r4 
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var24 var3064)) ; Cond: i1 >= $i0 
 ; Statement: return 
; {resultsSlot/506553339=([org.docx4j.model.fields.FieldRef], org.docx4j.wml.R), getContent/2060121830=([org.docx4j.wml.R], java.util.List), var218_clear/2124191932=([java.util.List], void)}
; {var1890=org.docx4j.model.fields.FieldRef, var2261=r0, var1401=r3, var3000=null_type, var1690=org.docx4j.wml.R, var806=$r1, var218=java.util.List, var3496=$r2, var3473=r4, var1497=z2, var24=i1, var3064=$i0}
; {org.docx4j.model.fields.FieldRef=var1890, r0=var2261, r3=var1401, null_type=var3000, org.docx4j.wml.R=var1690, $r1=var806, java.util.List=var218, $r2=var3496, r4=var3473, z2=var1497, i1=var24, $i0=var3064}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.docx4j.model.fields.FieldRef;	r3 := @parameter0: java.lang.String;	$r1 = r0.<org.docx4j.model.fields.FieldRef: org.docx4j.wml.R resultsSlot>;	$r2 = virtualinvoke $r1.<org.docx4j.wml.R: java.util.List getContent()>();	interfaceinvoke $r2.<java.util.List: void clear()>();	r4 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\R");	z2 = 1;	i1 = 0;	$i0 = lengthof r4;	if i1 >= $i0 goto return;	return
;block_num 3
(check-sat)
(exit)
