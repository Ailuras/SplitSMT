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

(declare-sort var2968 0)
(declare-sort var3772 0)
(declare-sort var1836 0)
(declare-sort var2543 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun headers/-562224243 (var2968) var3772)
(declare-fun var3772_getFirst/-2132893997 (var3772 String) String)
(declare-fun var1836_isEmpty/-813097145 (String) Bool)
(declare-const null-var2968 var2968)
(declare-const null-String String)
(declare-const null-var2543 var2543)
(declare-const var2204 var2968) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var2204 null-var2968)))
(declare-const var3782 String) ; Statement: r1 := @parameter0: java.lang.CharSequence 
(assert (not (= var3782 null-String)))
(define-const var2319 var3772 (headers/-562224243 var2204)) ; Statement: $r2 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: org.apache.dubbo.remoting.http12.HttpHeaders headers> 
(define-const var2248 String (var3772_getFirst/-2132893997 var2319 var3782)) ; Statement: r3 = interfaceinvoke $r2.<org.apache.dubbo.remoting.http12.HttpHeaders: java.lang.String getFirst(java.lang.CharSequence)>(r1) 
(define-const var3992 Bool (var1836_isEmpty/-813097145 var2248)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = staticinvoke <io.netty.handler.codec.DateFormatter: java.util.Date parseHttpDate(java.lang.CharSequence)>(r3) 
(assert (not (= (ite var3992 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2409 var2543 null-var2543) ; Statement: $r4 = null 
 ; Statement: goto [?= return $r4] 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {headers/-562224243=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], org.apache.dubbo.remoting.http12.HttpHeaders), var3772_getFirst/-2132893997=([org.apache.dubbo.remoting.http12.HttpHeaders, java.lang.CharSequence], java.lang.String), var1836_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2968=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var2204=r0, var3782=r1, var3772=org.apache.dubbo.remoting.http12.HttpHeaders, var2319=$r2, var2248=r3, var1836=org.apache.dubbo.common.utils.StringUtils, var3992=$z0, var2543=java.util.Date, var2409=$r4}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var2968, r0=var2204, r1=var3782, org.apache.dubbo.remoting.http12.HttpHeaders=var3772, $r2=var2319, r3=var2248, org.apache.dubbo.common.utils.StringUtils=var1836, $z0=var3992, java.util.Date=var2543, $r4=var2409}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	r1 := @parameter0: java.lang.CharSequence;	$r2 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: org.apache.dubbo.remoting.http12.HttpHeaders headers>;	r3 = interfaceinvoke $r2.<org.apache.dubbo.remoting.http12.HttpHeaders: java.lang.String getFirst(java.lang.CharSequence)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r4 = staticinvoke <io.netty.handler.codec.DateFormatter: java.util.Date parseHttpDate(java.lang.CharSequence)>(r3);	$r4 = null;	goto [?= return $r4];	return $r4
;block_num 3