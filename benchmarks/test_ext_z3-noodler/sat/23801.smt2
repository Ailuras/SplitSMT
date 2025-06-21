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

(declare-sort var190 0)
(declare-sort var3008 0)
(declare-sort var1674 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3008_isEmpty/-813097145 (String) Bool)
(declare-fun var1674_encodeComponent/-442107119 (String) String)
(declare-const null-String String)
(declare-const var780 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var780 null-String)))
(define-const var684 Bool (var3008_isEmpty/-813097145 var780)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.rpc.TriRpcStatus: java.lang.String encodeComponent(java.lang.String)>(r0) 
(assert (= (ite var684 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2745 String (var1674_encodeComponent/-442107119 var780)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.rpc.TriRpcStatus: java.lang.String encodeComponent(java.lang.String)>(r0) 
 ; Statement: return $r1 
(check-sat)
; {var3008_isEmpty/-813097145=([java.lang.String], boolean), var1674_encodeComponent/-442107119=([java.lang.String], java.lang.String)}
; {var780=r0, var190=null_type, var3008=org.apache.dubbo.common.utils.StringUtils, var684=$z0, var1674=org.apache.dubbo.rpc.TriRpcStatus, var2745=$r1}
; {r0=var780, null_type=var190, org.apache.dubbo.common.utils.StringUtils=var3008, $z0=var684, org.apache.dubbo.rpc.TriRpcStatus=var1674, $r1=var2745}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.rpc.TriRpcStatus: java.lang.String encodeComponent(java.lang.String)>(r0);	$r1 = staticinvoke <org.apache.dubbo.rpc.TriRpcStatus: java.lang.String encodeComponent(java.lang.String)>(r0);	return $r1
;block_num 2