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

(declare-sort var695 0)
(declare-sort var839 0)
(declare-sort var3262 0)
(declare-sort var1985 0)
(declare-sort var182 0)
(declare-sort var2845 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun customizeHeaders/-1503454790 (var182 var839 var3262 var1985) void)
(declare-fun cast-from-var695-to-var182 (var695) var182)
(declare-fun getKey/83978900 (var2845) String)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun var839_set/12707091 (var839 String String) var839)
(declare-const null-var695 var695)
(declare-const null-var839 var839)
(declare-const null-var3262 var3262)
(declare-const null-var1985 var1985)
(declare-const var2845-CONTENT_LENGTH var2845)
(declare-const var2898 var695) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.h12.http1.Http1UnaryServerChannelObserver 
(assert (not (= var2898 null-var695)))
(declare-const var1438 var839) ; Statement: r1 := @parameter0: org.apache.dubbo.remoting.http12.HttpHeaders 
(assert (not (= var1438 null-var839)))
(declare-const var725 var3262) ; Statement: r2 := @parameter1: java.lang.Throwable 
(assert (not (= var725 null-var3262)))
(declare-const var1245 var1985) ; Statement: r3 := @parameter2: org.apache.dubbo.remoting.http12.HttpOutputMessage 
(assert (not (= var1245 null-var1985)))
(assert true)
;(assert (customizeHeaders/-1503454790 (cast-from-var695-to-var182 var2898) var1438 var725 var1245)) ; Statement: specialinvoke r0.<org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver: void customizeHeaders(org.apache.dubbo.remoting.http12.HttpHeaders,java.lang.Throwable,org.apache.dubbo.remoting.http12.HttpOutputMessage)>(r1, r2, r3) 

(declare-const var2898!1 var695)
(declare-const var1438!1 var839)
(declare-const var725!1 var3262)
(declare-const var1245!1 var1985)
(define-const var3772 Int 0) ; Statement: i0 = 0 
 ; Statement: if r3 == null goto $r13 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames CONTENT_LENGTH> 
(assert (= var1245!1 null-var1985)) ; Cond: r3 == null 
(define-const var1824 var2845 var2845-CONTENT_LENGTH) ; Statement: $r13 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames CONTENT_LENGTH> 
(assert true)
(define-const var2121 String (getKey/83978900 var1824)) ; Statement: $r14 = virtualinvoke $r13.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.CharSequence getKey()>() 
(define-const var1549 String (String_valueOf/1240665136 var3772)) ; Statement: $r15 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
;(assert (var839_set/12707091 var1438!1 var2121 var1549)) ; Statement: interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpHeaders: org.apache.dubbo.remoting.http12.HttpHeaders set(java.lang.CharSequence,java.lang.String)>($r14, $r15) 

(declare-const var1438!2 var839)
(declare-const var2121!1 String)
(declare-const var1549!1 String)
 ; Statement: return 
(check-sat)
; {customizeHeaders/-1503454790=([org.apache.dubbo.remoting.http12.AbstractServerHttpChannelObserver, org.apache.dubbo.remoting.http12.HttpHeaders, java.lang.Throwable, org.apache.dubbo.remoting.http12.HttpOutputMessage], void), cast-from-var695-to-var182=([org.apache.dubbo.rpc.protocol.tri.h12.http1.Http1UnaryServerChannelObserver], org.apache.dubbo.remoting.http12.AbstractServerHttpChannelObserver), getKey/83978900=([org.apache.dubbo.remoting.http12.HttpHeaderNames], java.lang.CharSequence), String_valueOf/1240665136=([int], java.lang.String), var839_set/12707091=([org.apache.dubbo.remoting.http12.HttpHeaders, java.lang.CharSequence, java.lang.String], org.apache.dubbo.remoting.http12.HttpHeaders)}
; {var695=org.apache.dubbo.rpc.protocol.tri.h12.http1.Http1UnaryServerChannelObserver, var2898=r0, var839=org.apache.dubbo.remoting.http12.HttpHeaders, var1438=r1, var3262=java.lang.Throwable, var725=r2, var1985=org.apache.dubbo.remoting.http12.HttpOutputMessage, var1245=r3, var182=org.apache.dubbo.remoting.http12.AbstractServerHttpChannelObserver, var3772=i0, var2845=org.apache.dubbo.remoting.http12.HttpHeaderNames, var1824=$r13, var2121=$r14, var1549=$r15}
; {org.apache.dubbo.rpc.protocol.tri.h12.http1.Http1UnaryServerChannelObserver=var695, r0=var2898, org.apache.dubbo.remoting.http12.HttpHeaders=var839, r1=var1438, java.lang.Throwable=var3262, r2=var725, org.apache.dubbo.remoting.http12.HttpOutputMessage=var1985, r3=var1245, org.apache.dubbo.remoting.http12.AbstractServerHttpChannelObserver=var182, i0=var3772, org.apache.dubbo.remoting.http12.HttpHeaderNames=var2845, $r13=var1824, $r14=var2121, $r15=var1549}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.h12.http1.Http1UnaryServerChannelObserver;	r1 := @parameter0: org.apache.dubbo.remoting.http12.HttpHeaders;	r2 := @parameter1: java.lang.Throwable;	r3 := @parameter2: org.apache.dubbo.remoting.http12.HttpOutputMessage;	specialinvoke r0.<org.apache.dubbo.remoting.http12.h1.Http1ServerChannelObserver: void customizeHeaders(org.apache.dubbo.remoting.http12.HttpHeaders,java.lang.Throwable,org.apache.dubbo.remoting.http12.HttpOutputMessage)>(r1, r2, r3);	i0 = 0;	if r3 == null goto $r13 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames CONTENT_LENGTH>;	$r13 = <org.apache.dubbo.remoting.http12.HttpHeaderNames: org.apache.dubbo.remoting.http12.HttpHeaderNames CONTENT_LENGTH>;	$r14 = virtualinvoke $r13.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.CharSequence getKey()>();	$r15 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	interfaceinvoke r1.<org.apache.dubbo.remoting.http12.HttpHeaders: org.apache.dubbo.remoting.http12.HttpHeaders set(java.lang.CharSequence,java.lang.String)>($r14, $r15);	return
;block_num 2