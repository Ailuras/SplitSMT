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

(declare-sort var994 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun fieldToString/1707619995 (var994) String)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var994 var994)
(declare-const var541 var994) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var541 null-var994)))
(define-const var1872 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1872)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1872!1 String)
(assert (= var1872!1 ""))
(assert true)
(define-const var2142 String (append/672562846 var1872!1 "DefaultHttpRequest{")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DefaultHttpRequest{") 
(declare-const var1872!2 String)
(assert (= var1872!2 (str.++ var1872!1 "DefaultHttpRequest{")))
(assert true)
(define-const var2961 String (fieldToString/1707619995 var541)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String fieldToString()>() 
(assert true)
(define-const var3317 String (append/672562846 var2142 var2961)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2142!1 String)
(assert (= var2142!1 (str.++ var2142 var2961)))
(assert true)
(define-const var184 String (append/-1166366385 var3317 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3317!1 String)
(assert (str.prefixof var3317 var3317!1))
(assert true)
(define-const var3394 String (toString/-2075883882 var184)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), fieldToString/1707619995=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var994=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var541=r1, var1872=$r0, var2142=$r3, var2961=$r2, var3317=$r4, var184=$r5, var3394=$r6}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var994, r1=var541, $r0=var1872, $r3=var2142, $r2=var2961, $r4=var3317, $r5=var184, $r6=var3394}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DefaultHttpRequest{");	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String fieldToString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1