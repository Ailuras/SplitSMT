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

(declare-sort var473 0)
(declare-sort var976 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-fun var976_isSnakeCase/-534208988 (String) Bool)
(declare-fun var976_replace/553341465 (String String String) String)
(declare-const null-String String)
(declare-const var1276 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1276 null-String)))
(declare-const var990 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var990 null-String)))
(assert true)
(define-const var2448 String (toLowerCase/415700667 var1276)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var2462 Bool (var976_isSnakeCase/-534208988 var1276)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto return r0 
(assert (not (= (ite var2462 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3736 String (var976_replace/553341465 var2448 "_" var990)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>(r1, "_", r2) 
 ; Statement: return $r3 
(check-sat)
; {toLowerCase/415700667=([java.lang.String], java.lang.String), var976_isSnakeCase/-534208988=([java.lang.String], boolean), var976_replace/553341465=([java.lang.String, java.lang.String, java.lang.String], java.lang.String)}
; {var1276=r0, var473=null_type, var990=r2, var2448=r1, var976=org.apache.dubbo.common.utils.StringUtils, var2462=$z0, var3736=$r3}
; {r0=var1276, null_type=var473, r2=var990, r1=var2448, org.apache.dubbo.common.utils.StringUtils=var976, $z0=var2462, $r3=var3736}
;seq <java.lang.String: java.lang.String toLowerCase()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String toLowerCase()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>(r0);	if $z0 == 0 goto return r0;	$r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>(r1, "_", r2);	return $r3
;block_num 2