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

(declare-sort var1410 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun Int_valueOf/1372619556 (String) Int)
(declare-fun compareTo/-1865131278 (Int Int) Int)
(declare-const null-String String)
(declare-const var1259 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1259 null-String)))
(declare-const var3053 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3053 null-String)))
; split operation: var3121 = var1259.split("\u005c.") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var3797 Int (get_split_length var1259 "\u005c." -1)) ; Statement: i0 = lengthof r1 
; split operation: var229 = var3053.split("\u005c.") ; Statement: r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var2124 Int (get_split_length var3053 "\u005c." -1)) ; Statement: i1 = lengthof r3 
(define-const var2851 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto (branch) 
(assert (>= var2851 var3797)) ; Cond: i3 >= i0 
 ; Statement: if i3 >= i0 goto (branch) 
(assert (not (>= var2851 var3797))) ; Negate: Cond: i3 >= i0  
 ; Statement: if i3 >= i1 goto (branch) 
(assert (not (>= var2851 var2124))) ; Negate: Cond: i3 >= i1  
(define-const var1592 String (get_split_element var1259 "\u005c." -1 var2851)) ; Statement: $r4 = r1[i3] 
(define-const var2472 Int (Int_valueOf/1372619556 var1592)) ; Statement: $r7 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(java.lang.String)>($r4) 
(define-const var1953 String (get_split_element var3053 "\u005c." -1 var2851)) ; Statement: $r5 = r3[i3] 
(define-const var3646 Int (Int_valueOf/1372619556 var1953)) ; Statement: $r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(java.lang.String)>($r5) 
(assert true)
(define-const var3045 Int (compareTo/-1865131278 var2472 var3646)) ; Statement: $i2 = virtualinvoke $r7.<java.lang.Integer: int compareTo(java.lang.Integer)>($r6) 
 ; Statement: return $i2 
(check-sat)
; {Int_valueOf/1372619556=([java.lang.String], java.lang.Integer), compareTo/-1865131278=([java.lang.Integer, java.lang.Integer], int)}
; {var1259=r0, var1410=null_type, var3053=r2, var3121=r1, var3797=i0, var229=r3, var2124=i1, var2851=i3, var1592=$r4, var2472=$r7, var1953=$r5, var3646=$r6, var3045=$i2}
; {r0=var1259, null_type=var1410, r2=var3053, r1=var3121, i0=var3797, r3=var229, i1=var2124, i3=var2851, $r4=var1592, $r7=var2472, $r5=var1953, $r6=var3646, $i2=var3045}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	i0 = lengthof r1;	r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	i1 = lengthof r3;	i3 = 0;	if i3 >= i0 goto (branch);	if i3 >= i0 goto (branch);	if i3 >= i1 goto (branch);	$r4 = r1[i3];	$r7 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(java.lang.String)>($r4);	$r5 = r3[i3];	$r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(java.lang.String)>($r5);	$i2 = virtualinvoke $r7.<java.lang.Integer: int compareTo(java.lang.Integer)>($r6);	return $i2
;block_num 5