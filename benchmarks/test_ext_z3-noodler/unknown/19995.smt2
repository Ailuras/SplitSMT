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

(declare-sort var556 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun fieldToString/193576045 (var556) String)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var556 var556)
(declare-const var3 var556) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse 
(assert (not (= var3 null-var556)))
(define-const var1236 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1236)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1236!1 String)
(assert (= var1236!1 ""))
(assert true)
(define-const var2562 String (append/672562846 var1236!1 "DefaultHttpResponse{")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DefaultHttpResponse{") 
(declare-const var1236!2 String)
(assert (= var1236!2 (str.++ var1236!1 "DefaultHttpResponse{")))
(assert true)
(define-const var2716 String (fieldToString/193576045 var3)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String fieldToString()>() 
(assert true)
(define-const var2665 String (append/672562846 var2562 var2716)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2562!1 String)
(assert (= var2562!1 (str.++ var2562 var2716)))
(assert true)
(define-const var2100 String (append/-1166366385 var2665 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2665!1 String)
(assert (str.prefixof var2665 var2665!1))
(assert true)
(define-const var114 String (toString/-2075883882 var2100)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), fieldToString/193576045=([org.apache.dubbo.remoting.http12.message.DefaultHttpResponse], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var556=org.apache.dubbo.remoting.http12.message.DefaultHttpResponse, var3=r1, var1236=$r0, var2562=$r3, var2716=$r2, var2665=$r4, var2100=$r5, var114=$r6}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpResponse=var556, r1=var3, $r0=var1236, $r3=var2562, $r2=var2716, $r4=var2665, $r5=var2100, $r6=var114}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DefaultHttpResponse{");	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String fieldToString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1