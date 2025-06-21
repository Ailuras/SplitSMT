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

(declare-sort var2575 0)
(declare-sort var1552 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1552_isSnakeCase/-534208988 (String) Bool)
(declare-fun var1552_camelToSplitName/-763255368 (String String) String)
(declare-const null-String String)
(declare-const var2813 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2813 null-String)))
(declare-const var2505 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2505 null-String)))
(define-const var2654 Bool (var1552_isSnakeCase/-534208988 var2813)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>(r0, r1) 
(assert (= (ite var2654 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3275 String (var1552_camelToSplitName/-763255368 var2813 var2505)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>(r0, r1) 
 ; Statement: return $r2 
(check-sat)
; {var1552_isSnakeCase/-534208988=([java.lang.String], boolean), var1552_camelToSplitName/-763255368=([java.lang.String, java.lang.String], java.lang.String)}
; {var2813=r0, var2575=null_type, var2505=r1, var1552=org.apache.dubbo.common.utils.StringUtils, var2654=$z0, var3275=$r2}
; {r0=var2813, null_type=var2575, r1=var2505, org.apache.dubbo.common.utils.StringUtils=var1552, $z0=var2654, $r2=var3275}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isSnakeCase(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>(r0, r1);	$r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String camelToSplitName(java.lang.String,java.lang.String)>(r0, r1);	return $r2
;block_num 2