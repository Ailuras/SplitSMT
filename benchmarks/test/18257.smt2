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

(declare-sort var1388 0)
(declare-sort var320 0)
(declare-sort var1852 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun headers/-215098934 (var1388) var320)
(declare-fun append/-1031950772 (String var1852) String)
(declare-fun cast-from-var320-to-var1852 (var320) var1852)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1388 var1388)
(declare-const var3683 var1388) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter 
(assert (not (= var3683 null-var1388)))
(define-const var254 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var254)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var254!1 String)
(assert (= var254!1 ""))
(assert true)
(define-const var2906 String (append/672562846 var254!1 "HttpHeadersMapAdapter{headers=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("HttpHeadersMapAdapter{headers=") 
(declare-const var254!2 String)
(assert (= var254!2 (str.++ var254!1 "HttpHeadersMapAdapter{headers=")))
(define-const var646 var320 (headers/-215098934 var3683)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter: org.apache.dubbo.remoting.http12.HttpHeaders headers> 
(assert true)
(define-const var1223 String (append/-1031950772 var2906 (cast-from-var320-to-var1852 var646))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2906!1 String)
(assert (str.prefixof var2906 var2906!1))
(assert true)
(define-const var985 String (append/-1166366385 var1223 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1223!1 String)
(assert (str.prefixof var1223 var1223!1))
(assert true)
(define-const var1535 String (toString/-2075883882 var985)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), headers/-215098934=([org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter], org.apache.dubbo.remoting.http12.HttpHeaders), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var320-to-var1852=([org.apache.dubbo.remoting.http12.HttpHeaders], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1388=org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter, var3683=r1, var254=$r0, var2906=$r3, var320=org.apache.dubbo.remoting.http12.HttpHeaders, var646=$r2, var1852=java.lang.Object, var1223=$r4, var985=$r5, var1535=$r6}
; {org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter=var1388, r1=var3683, $r0=var254, $r3=var2906, org.apache.dubbo.remoting.http12.HttpHeaders=var320, $r2=var646, java.lang.Object=var1852, $r4=var1223, $r5=var985, $r6=var1535}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("HttpHeadersMapAdapter{headers=");	$r2 = r1.<org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter: org.apache.dubbo.remoting.http12.HttpHeaders headers>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1