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

(declare-sort var1955 0)
(declare-sort var2359 0)
(declare-sort var899 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun headers/316799886 (var1955) var2359)
(declare-fun append/-1031950772 (String var899) String)
(declare-fun cast-from-var2359-to-var899 (var2359) var899)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1955 var1955)
(declare-const var387 var1955) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.netty4.h1.NettyHttp1HttpHeaders 
(assert (not (= var387 null-var1955)))
(define-const var3499 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3499)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3499!1 String)
(assert (= var3499!1 ""))
(assert true)
(define-const var820 String (append/672562846 var3499!1 "NettyHttp1HttpHeaders{headers=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("NettyHttp1HttpHeaders{headers=") 
(declare-const var3499!2 String)
(assert (= var3499!2 (str.++ var3499!1 "NettyHttp1HttpHeaders{headers=")))
(define-const var2603 var2359 (headers/316799886 var387)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.http12.netty4.h1.NettyHttp1HttpHeaders: io.netty.handler.codec.http.HttpHeaders headers> 
(assert true)
(define-const var577 String (append/-1031950772 var820 (cast-from-var2359-to-var899 var2603))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var820!1 String)
(assert (str.prefixof var820 var820!1))
(assert true)
(define-const var2735 String (append/-1166366385 var577 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var577!1 String)
(assert (str.prefixof var577 var577!1))
(assert true)
(define-const var667 String (toString/-2075883882 var2735)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), headers/316799886=([org.apache.dubbo.remoting.http12.netty4.h1.NettyHttp1HttpHeaders], io.netty.handler.codec.http.HttpHeaders), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2359-to-var899=([io.netty.handler.codec.http.HttpHeaders], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1955=org.apache.dubbo.remoting.http12.netty4.h1.NettyHttp1HttpHeaders, var387=r1, var3499=$r0, var820=$r3, var2359=io.netty.handler.codec.http.HttpHeaders, var2603=$r2, var899=java.lang.Object, var577=$r4, var2735=$r5, var667=$r6}
; {org.apache.dubbo.remoting.http12.netty4.h1.NettyHttp1HttpHeaders=var1955, r1=var387, $r0=var3499, $r3=var820, io.netty.handler.codec.http.HttpHeaders=var2359, $r2=var2603, java.lang.Object=var899, $r4=var577, $r5=var2735, $r6=var667}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.netty4.h1.NettyHttp1HttpHeaders;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("NettyHttp1HttpHeaders{headers=");	$r2 = r1.<org.apache.dubbo.remoting.http12.netty4.h1.NettyHttp1HttpHeaders: io.netty.handler.codec.http.HttpHeaders headers>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1