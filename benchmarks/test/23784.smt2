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

(declare-sort var3384 0)
(declare-sort var2530 0)
(declare-sort var3627 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2530_isEmpty/-813097145 (String) Bool)
(declare-fun var3627_decodeComponent/1755795723 (String) String)
(declare-const null-String String)
(declare-const var1925 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1925 null-String)))
(define-const var2394 Bool (var2530_isEmpty/-813097145 var1925)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <io.netty.handler.codec.http.QueryStringDecoder: java.lang.String decodeComponent(java.lang.String)>(r0) 
(assert (= (ite var2394 1 0) 0)) ; Cond: $z0 == 0 
(define-const var812 String (var3627_decodeComponent/1755795723 var1925)) ; Statement: $r1 = staticinvoke <io.netty.handler.codec.http.QueryStringDecoder: java.lang.String decodeComponent(java.lang.String)>(r0) 
 ; Statement: return $r1 
(check-sat)
; {var2530_isEmpty/-813097145=([java.lang.String], boolean), var3627_decodeComponent/1755795723=([java.lang.String], java.lang.String)}
; {var1925=r0, var3384=null_type, var2530=org.apache.dubbo.common.utils.StringUtils, var2394=$z0, var3627=io.netty.handler.codec.http.QueryStringDecoder, var812=$r1}
; {r0=var1925, null_type=var3384, org.apache.dubbo.common.utils.StringUtils=var2530, $z0=var2394, io.netty.handler.codec.http.QueryStringDecoder=var3627, $r1=var812}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = staticinvoke <io.netty.handler.codec.http.QueryStringDecoder: java.lang.String decodeComponent(java.lang.String)>(r0);	$r1 = staticinvoke <io.netty.handler.codec.http.QueryStringDecoder: java.lang.String decodeComponent(java.lang.String)>(r0);	return $r1
;block_num 2