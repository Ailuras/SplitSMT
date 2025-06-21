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

(declare-sort var1424 0)
(declare-sort var834 0)
(declare-sort var2146 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun header/-1589726683 (var1424 String) String)
(declare-fun var834_isEmpty/-813097145 (String) Bool)
(declare-const null-var1424 var1424)
(declare-const null-String String)
(declare-const null-var2146 var2146)
(declare-const var2924 var1424) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse 
(assert (not (= var2924 null-var1424)))
(declare-const var846 String) ; Statement: r1 := @parameter0: java.lang.CharSequence 
(assert (not (= var846 null-String)))
(assert true)
(define-const var3401 String (header/-1589726683 var2924 var846)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String header(java.lang.CharSequence)>(r1) 
(define-const var1339 Bool (var834_isEmpty/-813097145 var3401)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <io.netty.handler.codec.DateFormatter: java.util.Date parseHttpDate(java.lang.CharSequence)>(r2) 
(assert (not (= (ite var1339 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2575 var2146 null-var2146) ; Statement: $r3 = null 
 ; Statement: goto [?= return $r3] 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {header/-1589726683=([org.apache.dubbo.remoting.http12.message.DefaultHttpResponse, java.lang.CharSequence], java.lang.String), var834_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1424=org.apache.dubbo.remoting.http12.message.DefaultHttpResponse, var2924=r0, var846=r1, var3401=r2, var834=org.apache.dubbo.common.utils.StringUtils, var1339=$z0, var2146=java.util.Date, var2575=$r3}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpResponse=var1424, r0=var2924, r1=var846, r2=var3401, org.apache.dubbo.common.utils.StringUtils=var834, $z0=var1339, java.util.Date=var2146, $r3=var2575}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse;	r1 := @parameter0: java.lang.CharSequence;	r2 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String header(java.lang.CharSequence)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = staticinvoke <io.netty.handler.codec.DateFormatter: java.util.Date parseHttpDate(java.lang.CharSequence)>(r2);	$r3 = null;	goto [?= return $r3];	return $r3
;block_num 3