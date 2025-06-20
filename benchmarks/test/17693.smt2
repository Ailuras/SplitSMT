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

(declare-sort var1531 0)
(declare-sort var2402 0)
(declare-sort var2857 0)
(declare-sort var1744 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun header/-1589726683 (var1531 String) String)
(declare-fun var2402_isEmpty/-813097145 (String) Bool)
(declare-fun var1744_parseHttpDate/1679869219 (String) var2857)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var1531 var1531)
(declare-const null-String String)
(declare-const var1336 var1531) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse 
(assert (not (= var1336 null-var1531)))
(declare-const var21 String) ; Statement: r1 := @parameter0: java.lang.CharSequence 
(assert (not (= var21 null-String)))
(assert true)
(define-const var1510 String (header/-1589726683 var1336 var21)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String header(java.lang.CharSequence)>(r1) 
(define-const var3229 Bool (var2402_isEmpty/-813097145 var1510)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <io.netty.handler.codec.DateFormatter: java.util.Date parseHttpDate(java.lang.CharSequence)>(r2) 
(assert (= (ite var3229 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2037 var2857 (var1744_parseHttpDate/1679869219 (cast-from-String-to-String var1510))) ; Statement: $r3 = staticinvoke <io.netty.handler.codec.DateFormatter: java.util.Date parseHttpDate(java.lang.CharSequence)>(r2) 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {header/-1589726683=([org.apache.dubbo.remoting.http12.message.DefaultHttpResponse, java.lang.CharSequence], java.lang.String), var2402_isEmpty/-813097145=([java.lang.String], boolean), var1744_parseHttpDate/1679869219=([java.lang.CharSequence], java.util.Date), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var1531=org.apache.dubbo.remoting.http12.message.DefaultHttpResponse, var1336=r0, var21=r1, var1510=r2, var2402=org.apache.dubbo.common.utils.StringUtils, var3229=$z0, var2857=java.util.Date, var1744=io.netty.handler.codec.DateFormatter, var2037=$r3}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpResponse=var1531, r0=var1336, r1=var21, r2=var1510, org.apache.dubbo.common.utils.StringUtils=var2402, $z0=var3229, java.util.Date=var2857, io.netty.handler.codec.DateFormatter=var1744, $r3=var2037}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse;	r1 := @parameter0: java.lang.CharSequence;	r2 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String header(java.lang.CharSequence)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = staticinvoke <io.netty.handler.codec.DateFormatter: java.util.Date parseHttpDate(java.lang.CharSequence)>(r2);	$r3 = staticinvoke <io.netty.handler.codec.DateFormatter: java.util.Date parseHttpDate(java.lang.CharSequence)>(r2);	return $r3
;block_num 3