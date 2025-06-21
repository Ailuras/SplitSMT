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

(declare-sort var1802 0)
(declare-sort var230 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun fieldToString/1707619995 (var230) String)
(declare-fun cast-from-var1802-to-var230 (var1802) var230)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1802 var1802)
(declare-const var1936 var1802) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter 
(assert (not (= var1936 null-var1802)))
(define-const var1128 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1128)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1128!1 String)
(assert (= var1128!1 ""))
(assert true)
(define-const var3982 String (append/672562846 var1128!1 "ServletHttpRequestAdapter{")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServletHttpRequestAdapter{") 
(declare-const var1128!2 String)
(assert (= var1128!2 (str.++ var1128!1 "ServletHttpRequestAdapter{")))
(assert true)
(define-const var3983 String (fieldToString/1707619995 (cast-from-var1802-to-var230 var1936))) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: java.lang.String fieldToString()>() 
(assert true)
(define-const var3961 String (append/672562846 var3982 var3983)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3982!1 String)
(assert (= var3982!1 (str.++ var3982 var3983)))
(assert true)
(define-const var2648 String (append/-1166366385 var3961 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3961!1 String)
(assert (str.prefixof var3961 var3961!1))
(assert true)
(define-const var1455 String (toString/-2075883882 var2648)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), fieldToString/1707619995=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), cast-from-var1802-to-var230=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter], org.apache.dubbo.remoting.http12.message.DefaultHttpRequest), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1802=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter, var1936=r1, var1128=$r0, var3982=$r3, var230=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var3983=$r2, var3961=$r4, var2648=$r5, var1455=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter=var1802, r1=var1936, $r0=var1128, $r3=var3982, org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var230, $r2=var3983, $r4=var3961, $r5=var2648, $r6=var1455}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServletHttpRequestAdapter{");	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: java.lang.String fieldToString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1