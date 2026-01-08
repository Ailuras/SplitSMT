(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

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

(declare-sort var453 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(declare-fun arr-Int-init () (Array Int Int))
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1471 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1471 null-String)))
; split operation: var757 = var1471.split("[,;]") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]") 
(define-const var535 Int 0) ; Statement: i9 = 0 
(define-const var593 Int (get_split_length var1471 "[,;]" -1)) ; Statement: $i0 = lengthof r1 
(define-const var462 (Array Int String) arr-String-init) ; Statement: r2 = newarray (java.lang.String)[$i0] 
(define-const var1056 Int (get_split_length var1471 "[,;]" -1)) ; Statement: $i1 = lengthof r1 
(define-const var2306 (Array Int Int) arr-Int-init) ; Statement: r3 = newarray (int)[$i1] 
(define-const var755 Int 0) ; Statement: i10 = 0 
(assert true) ; Non Conditional
(define-const var114 Int (get_split_length var1471 "[,;]" -1)) ; Statement: $i2 = lengthof r1 
 ; Statement: if i10 >= $i2 goto $i3 = i9 + 1 
(assert (>= var755 var114)) ; Cond: i10 >= $i2 
(define-const var567 Int (+ var535 1)) ; Statement: $i3 = i9 + 1 
(define-const var1143 (Array Int String) arr-String-init) ; Statement: r10 = newarray (java.lang.String)[$i3] 
(define-const var2569 Int 0) ; Statement: i12 = 0 
(assert true) ; Non Conditional
(define-const var1113 Int (get_split_length var1471 "[,;]" -1)) ; Statement: $i4 = lengthof r1 
 ; Statement: if i12 >= $i4 goto return r10 
(assert (not (>= var2569 var1113))) ; Negate: Cond: i12 >= $i4  
(define-const var3518 Int (select var2306 var2569)) ; Statement: $i5 = r3[i12] 
(define-const var305 String (select var462 var2569)) ; Statement: $r4 = r2[i12] 
(declare-const var1143!1 (Array Int String))
(assert (not (= var1143!1 null-__Array__Int__String__)))
(assert (= (select var1143!1 var3518) var305)) ; Statement: r10[$i5] = $r4 
(define-const var2569!1 Int (+ var2569 1)) ; Statement: i12 = i12 + 1 
 ; Statement: goto [?= $i4 = lengthof r1] 
(assert true) ; Non Conditional
(define-const var1113!1 Int (get_split_length var1471 "[,;]" -1)) ; Statement: $i4 = lengthof r1 
 ; Statement: if i12 >= $i4 goto return r10 
(assert (>= var2569!1 var1113!1)) ; Cond: i12 >= $i4 
 ; Statement: return r10 
(check-sat)
; {arr-String-init=([], java.lang.String[]), arr-Int-init=([], int[])}
; {var1471=r0, var453=null_type, var757=r1, var535=i9, var593=$i0, var462=r2, var1056=$i1, var2306=r3, var755=i10, var114=$i2, var567=$i3, var1143=r10, var2569=i12, var1113=$i4, var3518=$i5, var305=$r4}
; {r0=var1471, null_type=var453, r1=var757, i9=var535, $i0=var593, r2=var462, $i1=var1056, r3=var2306, i10=var755, $i2=var114, $i3=var567, r10=var1143, i12=var2569, $i4=var1113, $i5=var3518, $r4=var305}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]");	i9 = 0;	$i0 = lengthof r1;	r2 = newarray (java.lang.String)[$i0];	$i1 = lengthof r1;	r3 = newarray (int)[$i1];	i10 = 0;	$i2 = lengthof r1;	if i10 >= $i2 goto $i3 = i9 + 1;	$i3 = i9 + 1;	r10 = newarray (java.lang.String)[$i3];	i12 = 0;	$i4 = lengthof r1;	if i12 >= $i4 goto return r10;	$i5 = r3[i12];	$r4 = r2[i12];	r10[$i5] = $r4;	i12 = i12 + 1;	goto [?= $i4 = lengthof r1];	$i4 = lengthof r1;	if i12 >= $i4 goto return r10;	return r10
;block_num 7
(exit)
