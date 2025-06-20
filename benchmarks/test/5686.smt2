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

(declare-sort var3021 0)
(declare-sort var3050 0)
(declare-sort var1718 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var3021 var3021)
(declare-const null-String String)
(declare-const var1718-TYPE ClassObject)
(declare-const var2525 var3021) ; Statement: r16 := @parameter0: java.lang.ClassLoader 
(assert (not (= var2525 null-var3021)))
(declare-const var2985 String) ; Statement: r17 := @parameter1: java.lang.String 
(assert (not (= var2985 null-String)))
(assert (and true (and (> (str.len var2985) 0) (<= 0 0))))
(define-const var3939 Int (charAt/698050440 var2985 0)) ; Statement: $c0 = virtualinvoke r17.<java.lang.String: char charAt(int)>(0) 
(define-const var3091 Int (cast-from-Int-to-Int var3939)) ; Statement: $i3 = (int) $c0 
 ; Statement: tableswitch($i3) {     case 66: goto $r10 = <java.lang.Byte: java.lang.Class TYPE>;     case 67: goto $r9 = <java.lang.Character: java.lang.Class TYPE>;     case 68: goto $r8 = <java.lang.Double: java.lang.Class TYPE>;     case 69: goto $r20 = new java.lang.ClassNotFoundException;     case 70: goto $r7 = <java.lang.Float: java.lang.Class TYPE>;     case 71: goto $r20 = new java.lang.ClassNotFoundException;     case 72: goto $r20 = new java.lang.ClassNotFoundException;     case 73: goto $r6 = <java.lang.Integer: java.lang.Class TYPE>;     case 74: goto $r5 = <java.lang.Long: java.lang.Class TYPE>;     case 75: goto $r20 = new java.lang.ClassNotFoundException;     case 76: goto $i1 = virtualinvoke r17.<java.lang.String: int length()>();     case 77: goto $r20 = new java.lang.ClassNotFoundException;     case 78: goto $r20 = new java.lang.ClassNotFoundException;     case 79: goto $r20 = new java.lang.ClassNotFoundException;     case 80: goto $r20 = new java.lang.ClassNotFoundException;     case 81: goto $r20 = new java.lang.ClassNotFoundException;     case 82: goto $r20 = new java.lang.ClassNotFoundException;     case 83: goto $r3 = <java.lang.Short: java.lang.Class TYPE>;     case 84: goto $r20 = new java.lang.ClassNotFoundException;     case 85: goto $r20 = new java.lang.ClassNotFoundException;     case 86: goto $r2 = <java.lang.Void: java.lang.Class TYPE>;     case 87: goto $r20 = new java.lang.ClassNotFoundException;     case 88: goto $r20 = new java.lang.ClassNotFoundException;     case 89: goto $r20 = new java.lang.ClassNotFoundException;     case 90: goto $r1 = <java.lang.Boolean: java.lang.Class TYPE>;     case 91: goto r18 = virtualinvoke r17.<java.lang.String: java.lang.String replace(char,char)>(47, 46);     default: goto $r20 = new java.lang.ClassNotFoundException; } 
(assert (and (= var3091 86) (and (not (= var3091 85)) (and (not (= var3091 84)) (and (not (= var3091 83)) (and (not (= var3091 82)) (and (not (= var3091 81)) (and (not (= var3091 80)) (and (not (= var3091 79)) (and (not (= var3091 78)) (and (not (= var3091 77)) (and (not (= var3091 76)) (and (not (= var3091 75)) (and (not (= var3091 74)) (and (not (= var3091 73)) (and (not (= var3091 72)) (and (not (= var3091 71)) (and (not (= var3091 70)) (and (not (= var3091 69)) (and (not (= var3091 68)) (and (not (= var3091 67)) (and (not (= var3091 66)) true)))))))))))))))))))))) ; Intersect: Cond: $i3 == 86  and Intersect: Negate: Cond: $i3 == 85   and Intersect: Negate: Cond: $i3 == 84   and Intersect: Negate: Cond: $i3 == 83   and Intersect: Negate: Cond: $i3 == 82   and Intersect: Negate: Cond: $i3 == 81   and Intersect: Negate: Cond: $i3 == 80   and Intersect: Negate: Cond: $i3 == 79   and Intersect: Negate: Cond: $i3 == 78   and Intersect: Negate: Cond: $i3 == 77   and Intersect: Negate: Cond: $i3 == 76   and Intersect: Negate: Cond: $i3 == 75   and Intersect: Negate: Cond: $i3 == 74   and Intersect: Negate: Cond: $i3 == 73   and Intersect: Negate: Cond: $i3 == 72   and Intersect: Negate: Cond: $i3 == 71   and Intersect: Negate: Cond: $i3 == 70   and Intersect: Negate: Cond: $i3 == 69   and Intersect: Negate: Cond: $i3 == 68   and Intersect: Negate: Cond: $i3 == 67   and Intersect: Negate: Cond: $i3 == 66   and Non Conditional                     
(define-const var1874 ClassObject var1718-TYPE) ; Statement: $r2 = <java.lang.Void: java.lang.Class TYPE> 
 ; Statement: return $r2 
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int)}
; {var3021=java.lang.ClassLoader, var2525=r16, var2985=r17, var3050=null_type, var3939=$c0, var3091=$i3, var1718=java.lang.Void, var1874=$r2}
; {java.lang.ClassLoader=var3021, r16=var2525, r17=var2985, null_type=var3050, $c0=var3939, $i3=var3091, java.lang.Void=var1718, $r2=var1874}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r16 := @parameter0: java.lang.ClassLoader;	r17 := @parameter1: java.lang.String;	$c0 = virtualinvoke r17.<java.lang.String: char charAt(int)>(0);	$i3 = (int) $c0;	tableswitch($i3) {     case 66: goto $r10 = <java.lang.Byte: java.lang.Class TYPE>;     case 67: goto $r9 = <java.lang.Character: java.lang.Class TYPE>;     case 68: goto $r8 = <java.lang.Double: java.lang.Class TYPE>;     case 69: goto $r20 = new java.lang.ClassNotFoundException;     case 70: goto $r7 = <java.lang.Float: java.lang.Class TYPE>;     case 71: goto $r20 = new java.lang.ClassNotFoundException;     case 72: goto $r20 = new java.lang.ClassNotFoundException;     case 73: goto $r6 = <java.lang.Integer: java.lang.Class TYPE>;     case 74: goto $r5 = <java.lang.Long: java.lang.Class TYPE>;     case 75: goto $r20 = new java.lang.ClassNotFoundException;     case 76: goto $i1 = virtualinvoke r17.<java.lang.String: int length()>();     case 77: goto $r20 = new java.lang.ClassNotFoundException;     case 78: goto $r20 = new java.lang.ClassNotFoundException;     case 79: goto $r20 = new java.lang.ClassNotFoundException;     case 80: goto $r20 = new java.lang.ClassNotFoundException;     case 81: goto $r20 = new java.lang.ClassNotFoundException;     case 82: goto $r20 = new java.lang.ClassNotFoundException;     case 83: goto $r3 = <java.lang.Short: java.lang.Class TYPE>;     case 84: goto $r20 = new java.lang.ClassNotFoundException;     case 85: goto $r20 = new java.lang.ClassNotFoundException;     case 86: goto $r2 = <java.lang.Void: java.lang.Class TYPE>;     case 87: goto $r20 = new java.lang.ClassNotFoundException;     case 88: goto $r20 = new java.lang.ClassNotFoundException;     case 89: goto $r20 = new java.lang.ClassNotFoundException;     case 90: goto $r1 = <java.lang.Boolean: java.lang.Class TYPE>;     case 91: goto r18 = virtualinvoke r17.<java.lang.String: java.lang.String replace(char,char)>(47, 46);     default: goto $r20 = new java.lang.ClassNotFoundException; };	$r2 = <java.lang.Void: java.lang.Class TYPE>;	return $r2
;block_num 2