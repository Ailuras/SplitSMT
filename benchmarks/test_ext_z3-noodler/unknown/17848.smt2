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

(declare-sort var1602 0)
(declare-sort var1567 0)
(declare-sort var1692 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun status/674660191 (var1602) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun headers/674660191 (var1602) var1567)
(declare-fun append/-1031950772 (String var1692) String)
(declare-fun cast-from-var1567-to-var1692 (var1567) var1692)
(declare-fun body/674660191 (var1602) var1692)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1602 var1602)
(declare-const var1270 var1602) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResult 
(assert (not (= var1270 null-var1602)))
(define-const var3373 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3373)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3373!1 String)
(assert (= var3373!1 ""))
(assert true)
(define-const var1174 String (append/672562846 var3373!1 "DefaultHttpResult{status=")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DefaultHttpResult{status=") 
(declare-const var3373!2 String)
(assert (= var3373!2 (str.++ var3373!1 "DefaultHttpResult{status=")))
(define-const var703 Int (status/674660191 var1270)) ; Statement: $i0 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult: int status> 
(assert true)
(define-const var2670 String (append/-1001720160 var1174 var703)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1174!1 String)
(assert (str.prefixof var1174 var1174!1))
(assert true)
(define-const var2566 String (append/672562846 var2670 ", headers=")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", headers=") 
(declare-const var2670!1 String)
(assert (= var2670!1 (str.++ var2670 ", headers=")))
(define-const var3106 var1567 (headers/674660191 var1270)) ; Statement: $r4 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult: java.util.Map headers> 
(assert true)
(define-const var2564 String (append/-1031950772 var2566 (cast-from-var1567-to-var1692 var3106))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4) 
(declare-const var2566!1 String)
(assert (str.prefixof var2566 var2566!1))
(assert true)
(define-const var2182 String (append/672562846 var2564 ", body=")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", body=") 
(declare-const var2564!1 String)
(assert (= var2564!1 (str.++ var2564 ", body=")))
(define-const var1933 var1692 (body/674660191 var1270)) ; Statement: $r7 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult: java.lang.Object body> 
(assert true)
(define-const var854 String (append/-1031950772 var2182 var1933)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7) 
(declare-const var2182!1 String)
(assert (str.prefixof var2182 var2182!1))
(assert true)
(define-const var1573 String (append/-1166366385 var854 125)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var854!1 String)
(assert (str.prefixof var854 var854!1))
(assert true)
(define-const var1317 String (toString/-2075883882 var1573)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), status/674660191=([org.apache.dubbo.remoting.http12.message.DefaultHttpResult], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), headers/674660191=([org.apache.dubbo.remoting.http12.message.DefaultHttpResult], java.util.Map), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1567-to-var1692=([java.util.Map], java.lang.Object), body/674660191=([org.apache.dubbo.remoting.http12.message.DefaultHttpResult], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1602=org.apache.dubbo.remoting.http12.message.DefaultHttpResult, var1270=r1, var3373=$r0, var1174=$r2, var703=$i0, var2670=$r3, var2566=$r5, var1567=java.util.Map, var3106=$r4, var1692=java.lang.Object, var2564=$r6, var2182=$r8, var1933=$r7, var854=$r9, var1573=$r10, var1317=$r11}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpResult=var1602, r1=var1270, $r0=var3373, $r2=var1174, $i0=var703, $r3=var2670, $r5=var2566, java.util.Map=var1567, $r4=var3106, java.lang.Object=var1692, $r6=var2564, $r8=var2182, $r7=var1933, $r9=var854, $r10=var1573, $r11=var1317}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResult;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DefaultHttpResult{status=");	$i0 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult: int status>;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", headers=");	$r4 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult: java.util.Map headers>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", body=");	$r7 = r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResult: java.lang.Object body>;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 1