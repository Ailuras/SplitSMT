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

(declare-sort var3764 0)
(declare-sort var3752 0)
(declare-sort var2291 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var3752-to-String (var3752) String)
(declare-fun var2291_isNotBlank/-358081771 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var3764 var3764)
(declare-const null-var3752 var3752)
(declare-const var484 var3764) ; Statement: $r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboCodec$isNotBlank__1322 
(assert (not (= var484 null-var3764)))
(declare-const var2602 var3752) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var2602 null-var3752)))
(define-const var374 String (cast-from-var3752-to-String var2602)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var1778 Bool (var2291_isNotBlank/-358081771 (cast-from-String-to-String var374))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var3752-to-String=([java.lang.Object], java.lang.String), var2291_isNotBlank/-358081771=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var3764=org.apache.dubbo.rpc.protocol.dubbo.DubboCodec$isNotBlank__1322, var484=$r0, var3752=java.lang.Object, var2602=$r1, var374=$r2, var2291=org.apache.dubbo.common.utils.StringUtils, var1778=$z0}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboCodec$isNotBlank__1322=var3764, $r0=var484, java.lang.Object=var3752, $r1=var2602, $r2=var374, org.apache.dubbo.common.utils.StringUtils=var2291, $z0=var1778}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>": 1}
;stmts $r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboCodec$isNotBlank__1322;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>($r2);	return $z0
;block_num 1