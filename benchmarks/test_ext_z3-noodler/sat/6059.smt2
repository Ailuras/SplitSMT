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

(declare-sort var2885 0)
(declare-sort var3466 0)
(declare-sort var3063 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3466_isEmpty/-813097145 (String) Bool)
(declare-fun var3466_parseKeyValuePair/100895876 (String String) var3063)
(declare-const null-String String)
(declare-const var3281 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3281 null-String)))
(define-const var1691 Bool (var3466_isEmpty/-813097145 var3281)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseKeyValuePair(java.lang.String,java.lang.String)>(r0, "\\&") 
(assert (= (ite var1691 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2298 var3063 (var3466_parseKeyValuePair/100895876 var3281 "\u005c&")) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseKeyValuePair(java.lang.String,java.lang.String)>(r0, "\\&") 
 ; Statement: return $r1 
(check-sat)
; {var3466_isEmpty/-813097145=([java.lang.String], boolean), var3466_parseKeyValuePair/100895876=([java.lang.String, java.lang.String], java.util.Map)}
; {var3281=r0, var2885=null_type, var3466=org.apache.dubbo.common.utils.StringUtils, var1691=$z0, var3063=java.util.Map, var2298=$r1}
; {r0=var3281, null_type=var2885, org.apache.dubbo.common.utils.StringUtils=var3466, $z0=var1691, java.util.Map=var3063, $r1=var2298}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.util.Map parseKeyValuePair(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.util.Map parseKeyValuePair(java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseKeyValuePair(java.lang.String,java.lang.String)>(r0, "\\&");	$r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseKeyValuePair(java.lang.String,java.lang.String)>(r0, "\\&");	return $r1
;block_num 2