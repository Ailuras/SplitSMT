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

(declare-sort var3281 0)
(declare-sort var190 0)
(declare-sort var1198 0)
(declare-sort var1651 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1198_getLocalHost/-1653363627 () String)
(declare-fun var1651_isEquals/882237642 (String String) Bool)
(declare-const null-var3281 var3281)
(declare-const null-String String)
(declare-const var3726 var3281) ; Statement: r2 := @this: org.apache.dubbo.remoting.transport.netty4.NettyClient 
(assert (not (= var3726 null-var3281)))
(declare-const var1797 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1797 null-String)))
(define-const var131 String var1198_getLocalHost/-1653363627) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(define-const var2514 Bool (var1651_isEquals/882237642 var131 var1797)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r1, r0) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var2514 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1615 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {var1198_getLocalHost/-1653363627=([], java.lang.String), var1651_isEquals/882237642=([java.lang.String, java.lang.String], boolean)}
; {var3281=org.apache.dubbo.remoting.transport.netty4.NettyClient, var3726=r2, var1797=r0, var190=null_type, var1198=org.apache.dubbo.common.utils.NetUtils, var131=$r1, var1651=org.apache.dubbo.common.utils.StringUtils, var2514=$z0, var1615=$z2}
; {org.apache.dubbo.remoting.transport.netty4.NettyClient=var3281, r2=var3726, r0=var1797, null_type=var190, org.apache.dubbo.common.utils.NetUtils=var1198, $r1=var131, org.apache.dubbo.common.utils.StringUtils=var1651, $z0=var2514, $z2=var1615}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.remoting.transport.netty4.NettyClient;	r0 := @parameter0: java.lang.String;	$r1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEquals(java.lang.String,java.lang.String)>($r1, r0);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3