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

(declare-sort var2039 0)
(declare-sort var923 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var2039 var2039)
(declare-const null-String String)
(declare-const Float64-TYPE ClassObject)
(declare-const var649 var2039) ; Statement: r16 := @parameter0: java.lang.ClassLoader 
(assert (not (= var649 null-var2039)))
(declare-const var3268 String) ; Statement: r17 := @parameter1: java.lang.String 
(assert (not (= var3268 null-String)))
(assert (and true (and (> (str.len var3268) 0) (<= 0 0))))
(define-const var2318 Int (charAt/698050440 var3268 0)) ; Statement: $c0 = virtualinvoke r17.<java.lang.String: char charAt(int)>(0) 
(define-const var1487 Int (cast-from-Int-to-Int var2318)) ; Statement: $i3 = (int) $c0 
 ; Statement: tableswitch($i3) {     case 66: goto $r10 = <java.lang.Byte: java.lang.Class TYPE>;     case 67: goto $r9 = <java.lang.Character: java.lang.Class TYPE>;     case 68: goto $r8 = <java.lang.Double: java.lang.Class TYPE>;     case 69: goto $r20 = new java.lang.ClassNotFoundException;     case 70: goto $r7 = <java.lang.Float: java.lang.Class TYPE>;     case 71: goto $r20 = new java.lang.ClassNotFoundException;     case 72: goto $r20 = new java.lang.ClassNotFoundException;     case 73: goto $r6 = <java.lang.Integer: java.lang.Class TYPE>;     case 74: goto $r5 = <java.lang.Long: java.lang.Class TYPE>;     case 75: goto $r20 = new java.lang.ClassNotFoundException;     case 76: goto $i1 = virtualinvoke r17.<java.lang.String: int length()>();     case 77: goto $r20 = new java.lang.ClassNotFoundException;     case 78: goto $r20 = new java.lang.ClassNotFoundException;     case 79: goto $r20 = new java.lang.ClassNotFoundException;     case 80: goto $r20 = new java.lang.ClassNotFoundException;     case 81: goto $r20 = new java.lang.ClassNotFoundException;     case 82: goto $r20 = new java.lang.ClassNotFoundException;     case 83: goto $r3 = <java.lang.Short: java.lang.Class TYPE>;     case 84: goto $r20 = new java.lang.ClassNotFoundException;     case 85: goto $r20 = new java.lang.ClassNotFoundException;     case 86: goto $r2 = <java.lang.Void: java.lang.Class TYPE>;     case 87: goto $r20 = new java.lang.ClassNotFoundException;     case 88: goto $r20 = new java.lang.ClassNotFoundException;     case 89: goto $r20 = new java.lang.ClassNotFoundException;     case 90: goto $r1 = <java.lang.Boolean: java.lang.Class TYPE>;     case 91: goto r18 = virtualinvoke r17.<java.lang.String: java.lang.String replace(char,char)>(47, 46);     default: goto $r20 = new java.lang.ClassNotFoundException; } 
(assert (and (= var1487 68) (and (not (= var1487 67)) (and (not (= var1487 66)) true)))) ; Intersect: Cond: $i3 == 68  and Intersect: Negate: Cond: $i3 == 67   and Intersect: Negate: Cond: $i3 == 66   and Non Conditional   
(define-const var1404 ClassObject Float64-TYPE) ; Statement: $r8 = <java.lang.Double: java.lang.Class TYPE> 
 ; Statement: return $r8 
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var2039=java.lang.ClassLoader, var649=r16, var3268=r17, var923=null_type, var2318=$c0, var1487=$i3, var1404=$r8}
; {java.lang.ClassLoader=var2039, r16=var649, r17=var3268, null_type=var923, $c0=var2318, $i3=var1487, $r8=var1404}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r16 := @parameter0: java.lang.ClassLoader;	r17 := @parameter1: java.lang.String;	$c0 = virtualinvoke r17.<java.lang.String: char charAt(int)>(0);	$i3 = (int) $c0;	tableswitch($i3) {     case 66: goto $r10 = <java.lang.Byte: java.lang.Class TYPE>;     case 67: goto $r9 = <java.lang.Character: java.lang.Class TYPE>;     case 68: goto $r8 = <java.lang.Double: java.lang.Class TYPE>;     case 69: goto $r20 = new java.lang.ClassNotFoundException;     case 70: goto $r7 = <java.lang.Float: java.lang.Class TYPE>;     case 71: goto $r20 = new java.lang.ClassNotFoundException;     case 72: goto $r20 = new java.lang.ClassNotFoundException;     case 73: goto $r6 = <java.lang.Integer: java.lang.Class TYPE>;     case 74: goto $r5 = <java.lang.Long: java.lang.Class TYPE>;     case 75: goto $r20 = new java.lang.ClassNotFoundException;     case 76: goto $i1 = virtualinvoke r17.<java.lang.String: int length()>();     case 77: goto $r20 = new java.lang.ClassNotFoundException;     case 78: goto $r20 = new java.lang.ClassNotFoundException;     case 79: goto $r20 = new java.lang.ClassNotFoundException;     case 80: goto $r20 = new java.lang.ClassNotFoundException;     case 81: goto $r20 = new java.lang.ClassNotFoundException;     case 82: goto $r20 = new java.lang.ClassNotFoundException;     case 83: goto $r3 = <java.lang.Short: java.lang.Class TYPE>;     case 84: goto $r20 = new java.lang.ClassNotFoundException;     case 85: goto $r20 = new java.lang.ClassNotFoundException;     case 86: goto $r2 = <java.lang.Void: java.lang.Class TYPE>;     case 87: goto $r20 = new java.lang.ClassNotFoundException;     case 88: goto $r20 = new java.lang.ClassNotFoundException;     case 89: goto $r20 = new java.lang.ClassNotFoundException;     case 90: goto $r1 = <java.lang.Boolean: java.lang.Class TYPE>;     case 91: goto r18 = virtualinvoke r17.<java.lang.String: java.lang.String replace(char,char)>(47, 46);     default: goto $r20 = new java.lang.ClassNotFoundException; };	$r8 = <java.lang.Double: java.lang.Class TYPE>;	return $r8
;block_num 2