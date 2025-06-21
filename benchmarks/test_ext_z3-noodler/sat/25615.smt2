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

(declare-sort var869 0)
(declare-sort var3923 0)
(declare-sort var3468 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3468_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var869 var869)
(declare-const null-String String)
(declare-const var1114 var869) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta 
(assert (not (= var1114 null-var869)))
(declare-const var570 String) ; Statement: r7 := @parameter1: java.lang.String 
(assert (not (= var570 null-String)))
(define-const var3645 Bool (var3468_isBlank/-523695098 (cast-from-String-to-String var570))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r7) 
 ; Statement: if $z0 == 0 goto r8 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.cors.CorsUtils: java.lang.String formatOrigin(java.lang.String)>(r7) 
(assert (not (= (ite var3645 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return null 
(check-sat)
; {var3468_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var869=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta, var1114=r0, var570=r7, var3923=null_type, var3468=org.apache.dubbo.common.utils.StringUtils, var3645=$z0}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta=var869, r0=var1114, r7=var570, null_type=var3923, org.apache.dubbo.common.utils.StringUtils=var3468, $z0=var3645}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta;	r7 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r7);	if $z0 == 0 goto r8 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.rest.cors.CorsUtils: java.lang.String formatOrigin(java.lang.String)>(r7);	return null
;block_num 2