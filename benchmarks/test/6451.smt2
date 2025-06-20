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

(declare-sort var3926 0)
(declare-sort var3287 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3287_isSnakeCase/-534208988 (String) Bool)
(declare-fun var3287_snakeToSplitName/852964334 (String String) String)
(declare-const null-String String)
(declare-const var453 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var453 null-String)))
(declare-const var605 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var605 null-String)))
(define-const var3455 Bool (var3287_isSnakeCase/-534208988 var453)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>(r0, r1) 
(assert (not (= (ite var3455 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var870 String (var3287_snakeToSplitName/852964334 var453 var605)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String snakeToSplitName(java.lang.String,java.lang.String)>(r0, r1) 
 ; Statement: return $r3 
(check-sat)
; {var3287_isSnakeCase/-534208988=([java.lang.String], boolean), var3287_snakeToSplitName/852964334=([java.lang.String, java.lang.String], java.lang.String)}
; {var453=r0, var3926=null_type, var605=r1, var3287=org.apache.dubbo.common.utils.StringUtils, var3455=$z0, var870=$r3}
; {r0=var453, null_type=var3926, r1=var605, org.apache.dubbo.common.utils.StringUtils=var3287, $z0=var3455, $r3=var870}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String snakeToSplitName(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.lang.String snakeToSplitName(java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>(r0, r1);	$r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String snakeToSplitName(java.lang.String,java.lang.String)>(r0, r1);	return $r3
;block_num 2