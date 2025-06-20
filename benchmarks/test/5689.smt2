(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var355 0)
(declare-sort var55 0)
(declare-sort var500 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var355 var355)
(declare-const null-String String)
(declare-const var500-TYPE ClassObject)
(declare-const var3229 var355) ; Statement: r16 := @parameter0: java.lang.ClassLoader 
(assert (not (= var3229 null-var355)))
(declare-const var1865 String) ; Statement: r17 := @parameter1: java.lang.String 
(assert (not (= var1865 null-String)))
(assert (and true (and (> (str.len var1865) 0) (<= 0 0))))
(define-const var3677 Int (charAt/698050440 var1865 0)) ; Statement: $c0 = virtualinvoke r17.<java.lang.String: char charAt(int)>(0) 
(define-const var840 Int (cast-from-Int-to-Int var3677)) ; Statement: $i3 = (int) $c0 
 ; Statement: tableswitch($i3) {     case 66: goto $r10 = <java.lang.Byte: java.lang.Class TYPE>;     case 67: goto $r9 = <java.lang.Character: java.lang.Class TYPE>;     case 68: goto $r8 = <java.lang.Double: java.lang.Class TYPE>;     case 69: goto $r20 = new java.lang.ClassNotFoundException;     case 70: goto $r7 = <java.lang.Float: java.lang.Class TYPE>;     case 71: goto $r20 = new java.lang.ClassNotFoundException;     case 72: goto $r20 = new java.lang.ClassNotFoundException;     case 73: goto $r6 = <java.lang.Integer: java.lang.Class TYPE>;     case 74: goto $r5 = <java.lang.Long: java.lang.Class TYPE>;     case 75: goto $r20 = new java.lang.ClassNotFoundException;     case 76: goto $i1 = virtualinvoke r17.<java.lang.String: int length()>();     case 77: goto $r20 = new java.lang.ClassNotFoundException;     case 78: goto $r20 = new java.lang.ClassNotFoundException;     case 79: goto $r20 = new java.lang.ClassNotFoundException;     case 80: goto $r20 = new java.lang.ClassNotFoundException;     case 81: goto $r20 = new java.lang.ClassNotFoundException;     case 82: goto $r20 = new java.lang.ClassNotFoundException;     case 83: goto $r3 = <java.lang.Short: java.lang.Class TYPE>;     case 84: goto $r20 = new java.lang.ClassNotFoundException;     case 85: goto $r20 = new java.lang.ClassNotFoundException;     case 86: goto $r2 = <java.lang.Void: java.lang.Class TYPE>;     case 87: goto $r20 = new java.lang.ClassNotFoundException;     case 88: goto $r20 = new java.lang.ClassNotFoundException;     case 89: goto $r20 = new java.lang.ClassNotFoundException;     case 90: goto $r1 = <java.lang.Boolean: java.lang.Class TYPE>;     case 91: goto r18 = virtualinvoke r17.<java.lang.String: java.lang.String replace(char,char)>(47, 46);     default: goto $r20 = new java.lang.ClassNotFoundException; } 
(assert (and (= var840 90) (and (not (= var840 89)) (and (not (= var840 88)) (and (not (= var840 87)) (and (not (= var840 86)) (and (not (= var840 85)) (and (not (= var840 84)) (and (not (= var840 83)) (and (not (= var840 82)) (and (not (= var840 81)) (and (not (= var840 80)) (and (not (= var840 79)) (and (not (= var840 78)) (and (not (= var840 77)) (and (not (= var840 76)) (and (not (= var840 75)) (and (not (= var840 74)) (and (not (= var840 73)) (and (not (= var840 72)) (and (not (= var840 71)) (and (not (= var840 70)) (and (not (= var840 69)) (and (not (= var840 68)) (and (not (= var840 67)) (and (not (= var840 66)) true)))))))))))))))))))))))))) ; Intersect: Cond: $i3 == 90  and Intersect: Negate: Cond: $i3 == 89   and Intersect: Negate: Cond: $i3 == 88   and Intersect: Negate: Cond: $i3 == 87   and Intersect: Negate: Cond: $i3 == 86   and Intersect: Negate: Cond: $i3 == 85   and Intersect: Negate: Cond: $i3 == 84   and Intersect: Negate: Cond: $i3 == 83   and Intersect: Negate: Cond: $i3 == 82   and Intersect: Negate: Cond: $i3 == 81   and Intersect: Negate: Cond: $i3 == 80   and Intersect: Negate: Cond: $i3 == 79   and Intersect: Negate: Cond: $i3 == 78   and Intersect: Negate: Cond: $i3 == 77   and Intersect: Negate: Cond: $i3 == 76   and Intersect: Negate: Cond: $i3 == 75   and Intersect: Negate: Cond: $i3 == 74   and Intersect: Negate: Cond: $i3 == 73   and Intersect: Negate: Cond: $i3 == 72   and Intersect: Negate: Cond: $i3 == 71   and Intersect: Negate: Cond: $i3 == 70   and Intersect: Negate: Cond: $i3 == 69   and Intersect: Negate: Cond: $i3 == 68   and Intersect: Negate: Cond: $i3 == 67   and Intersect: Negate: Cond: $i3 == 66   and Non Conditional                         
(define-const var509 ClassObject var500-TYPE) ; Statement: $r1 = <java.lang.Boolean: java.lang.Class TYPE> 
 ; Statement: return $r1 
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var355=java.lang.ClassLoader, var3229=r16, var1865=r17, var55=null_type, var3677=$c0, var840=$i3, var500=java.lang.Boolean, var509=$r1}
; {java.lang.ClassLoader=var355, r16=var3229, r17=var1865, null_type=var55, $c0=var3677, $i3=var840, java.lang.Boolean=var500, $r1=var509}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r16 := @parameter0: java.lang.ClassLoader;	r17 := @parameter1: java.lang.String;	$c0 = virtualinvoke r17.<java.lang.String: char charAt(int)>(0);	$i3 = (int) $c0;	tableswitch($i3) {     case 66: goto $r10 = <java.lang.Byte: java.lang.Class TYPE>;     case 67: goto $r9 = <java.lang.Character: java.lang.Class TYPE>;     case 68: goto $r8 = <java.lang.Double: java.lang.Class TYPE>;     case 69: goto $r20 = new java.lang.ClassNotFoundException;     case 70: goto $r7 = <java.lang.Float: java.lang.Class TYPE>;     case 71: goto $r20 = new java.lang.ClassNotFoundException;     case 72: goto $r20 = new java.lang.ClassNotFoundException;     case 73: goto $r6 = <java.lang.Integer: java.lang.Class TYPE>;     case 74: goto $r5 = <java.lang.Long: java.lang.Class TYPE>;     case 75: goto $r20 = new java.lang.ClassNotFoundException;     case 76: goto $i1 = virtualinvoke r17.<java.lang.String: int length()>();     case 77: goto $r20 = new java.lang.ClassNotFoundException;     case 78: goto $r20 = new java.lang.ClassNotFoundException;     case 79: goto $r20 = new java.lang.ClassNotFoundException;     case 80: goto $r20 = new java.lang.ClassNotFoundException;     case 81: goto $r20 = new java.lang.ClassNotFoundException;     case 82: goto $r20 = new java.lang.ClassNotFoundException;     case 83: goto $r3 = <java.lang.Short: java.lang.Class TYPE>;     case 84: goto $r20 = new java.lang.ClassNotFoundException;     case 85: goto $r20 = new java.lang.ClassNotFoundException;     case 86: goto $r2 = <java.lang.Void: java.lang.Class TYPE>;     case 87: goto $r20 = new java.lang.ClassNotFoundException;     case 88: goto $r20 = new java.lang.ClassNotFoundException;     case 89: goto $r20 = new java.lang.ClassNotFoundException;     case 90: goto $r1 = <java.lang.Boolean: java.lang.Class TYPE>;     case 91: goto r18 = virtualinvoke r17.<java.lang.String: java.lang.String replace(char,char)>(47, 46);     default: goto $r20 = new java.lang.ClassNotFoundException; };	$r1 = <java.lang.Boolean: java.lang.Class TYPE>;	return $r1
;block_num 2