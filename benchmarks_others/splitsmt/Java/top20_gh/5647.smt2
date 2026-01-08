(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3214 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun Int_valueOf/1372619556 (String) Int)
(declare-fun compareTo/-1865131278 (Int Int) Int)
(declare-const null-String String)
(declare-const var761 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var761 null-String)))
(declare-const var1600 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1600 null-String)))
; split operation: var1835 = var761.split("\u005c.") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var1017 Int (get_split_length var761 "\u005c." -1)) ; Statement: i0 = lengthof r1 
; split operation: var1449 = var1600.split("\u005c.") ; Statement: r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var341 Int (get_split_length var1600 "\u005c." -1)) ; Statement: i1 = lengthof r3 
(define-const var3653 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto (branch) 
(assert (>= var3653 var1017)) ; Cond: i3 >= i0 
 ; Statement: if i3 >= i0 goto (branch) 
(assert (not (>= var3653 var1017))) ; Negate: Cond: i3 >= i0  
 ; Statement: if i3 >= i1 goto (branch) 
(assert (not (>= var3653 var341))) ; Negate: Cond: i3 >= i1  
(define-const var3348 String (get_split_element var761 "\u005c." -1 var3653)) ; Statement: $r4 = r1[i3] 
(define-const var3559 Int (Int_valueOf/1372619556 var3348)) ; Statement: $r7 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(java.lang.String)>($r4) 
(define-const var3498 String (get_split_element var1600 "\u005c." -1 var3653)) ; Statement: $r5 = r3[i3] 
(define-const var1286 Int (Int_valueOf/1372619556 var3498)) ; Statement: $r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(java.lang.String)>($r5) 
(assert true)
(define-const var519 Int (compareTo/-1865131278 var3559 var1286)) ; Statement: $i2 = virtualinvoke $r7.<java.lang.Integer: int compareTo(java.lang.Integer)>($r6) 
 ; Statement: return $i2 
(check-sat)
; {Int_valueOf/1372619556=([java.lang.String], java.lang.Integer), compareTo/-1865131278=([java.lang.Integer, java.lang.Integer], int)}
; {var761=r0, var3214=null_type, var1600=r2, var1835=r1, var1017=i0, var1449=r3, var341=i1, var3653=i3, var3348=$r4, var3559=$r7, var3498=$r5, var1286=$r6, var519=$i2}
; {r0=var761, null_type=var3214, r2=var1600, r1=var1835, i0=var1017, r3=var1449, i1=var341, i3=var3653, $r4=var3348, $r7=var3559, $r5=var3498, $r6=var1286, $i2=var519}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	i0 = lengthof r1;	r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	i1 = lengthof r3;	i3 = 0;	if i3 >= i0 goto (branch);	if i3 >= i0 goto (branch);	if i3 >= i1 goto (branch);	$r4 = r1[i3];	$r7 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(java.lang.String)>($r4);	$r5 = r3[i3];	$r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(java.lang.String)>($r5);	$i2 = virtualinvoke $r7.<java.lang.Integer: int compareTo(java.lang.Integer)>($r6);	return $i2
;block_num 5
