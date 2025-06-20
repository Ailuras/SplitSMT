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

(declare-sort var1282 0)
(declare-sort var2182 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun fieldToString/193576045 (var2182) String)
(declare-fun cast-from-var1282-to-var2182 (var1282) var2182)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1282 var1282)
(declare-const var737 var1282) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter 
(assert (not (= var737 null-var1282)))
(define-const var774 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var774)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var774!1 String)
(assert (= var774!1 ""))
(assert true)
(define-const var2153 String (append/672562846 var774!1 "ServletHttpResponseAdapter{")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServletHttpResponseAdapter{") 
(declare-const var774!2 String)
(assert (= var774!2 (str.++ var774!1 "ServletHttpResponseAdapter{")))
(assert true)
(define-const var1565 String (fieldToString/193576045 (cast-from-var1282-to-var2182 var737))) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter: java.lang.String fieldToString()>() 
(assert true)
(define-const var3278 String (append/672562846 var2153 var1565)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2153!1 String)
(assert (= var2153!1 (str.++ var2153 var1565)))
(assert true)
(define-const var1533 String (append/-1166366385 var3278 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3278!1 String)
(assert (str.prefixof var3278 var3278!1))
(assert true)
(define-const var2364 String (toString/-2075883882 var1533)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), fieldToString/193576045=([org.apache.dubbo.remoting.http12.message.DefaultHttpResponse], java.lang.String), cast-from-var1282-to-var2182=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter], org.apache.dubbo.remoting.http12.message.DefaultHttpResponse), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1282=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter, var737=r1, var774=$r0, var2153=$r3, var2182=org.apache.dubbo.remoting.http12.message.DefaultHttpResponse, var1565=$r2, var3278=$r4, var1533=$r5, var2364=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter=var1282, r1=var737, $r0=var774, $r3=var2153, org.apache.dubbo.remoting.http12.message.DefaultHttpResponse=var2182, $r2=var1565, $r4=var3278, $r5=var1533, $r6=var2364}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServletHttpResponseAdapter{");	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpResponseAdapter: java.lang.String fieldToString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1