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

(declare-sort var3203 0)
(declare-sort var1486 0)
(declare-sort var3558 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun headers/759095264 (var3203) var1486)
(declare-fun append/-1031950772 (String var3558) String)
(declare-fun cast-from-var1486-to-var3558 (var1486) var3558)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3203 var3203)
(declare-const var3616 var3203) ; Statement: r1 := @this: org.apache.dubbo.remoting.http3.netty4.Http3HeadersAdapter 
(assert (not (= var3616 null-var3203)))
(define-const var1635 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1635)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1635!1 String)
(assert (= var1635!1 ""))
(assert true)
(define-const var3011 String (append/672562846 var1635!1 "Http3HeadersAdapter{headers=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Http3HeadersAdapter{headers=") 
(declare-const var1635!2 String)
(assert (= var1635!2 (str.++ var1635!1 "Http3HeadersAdapter{headers=")))
(define-const var2958 var1486 (headers/759095264 var3616)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.http3.netty4.Http3HeadersAdapter: io.netty.handler.codec.http2.Http2Headers headers> 
(assert true)
(define-const var371 String (append/-1031950772 var3011 (cast-from-var1486-to-var3558 var2958))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var3011!1 String)
(assert (str.prefixof var3011 var3011!1))
(assert true)
(define-const var426 String (append/-1166366385 var371 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var371!1 String)
(assert (str.prefixof var371 var371!1))
(assert true)
(define-const var63 String (toString/-2075883882 var426)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), headers/759095264=([org.apache.dubbo.remoting.http3.netty4.Http3HeadersAdapter], io.netty.handler.codec.http2.Http2Headers), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1486-to-var3558=([io.netty.handler.codec.http2.Http2Headers], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3203=org.apache.dubbo.remoting.http3.netty4.Http3HeadersAdapter, var3616=r1, var1635=$r0, var3011=$r3, var1486=io.netty.handler.codec.http2.Http2Headers, var2958=$r2, var3558=java.lang.Object, var371=$r4, var426=$r5, var63=$r6}
; {org.apache.dubbo.remoting.http3.netty4.Http3HeadersAdapter=var3203, r1=var3616, $r0=var1635, $r3=var3011, io.netty.handler.codec.http2.Http2Headers=var1486, $r2=var2958, java.lang.Object=var3558, $r4=var371, $r5=var426, $r6=var63}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http3.netty4.Http3HeadersAdapter;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Http3HeadersAdapter{headers=");	$r2 = r1.<org.apache.dubbo.remoting.http3.netty4.Http3HeadersAdapter: io.netty.handler.codec.http2.Http2Headers headers>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1