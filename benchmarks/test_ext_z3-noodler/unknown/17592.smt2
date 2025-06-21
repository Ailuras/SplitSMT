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

(declare-sort var2587 0)
(declare-sort var696 0)
(declare-sort var2199 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun result/-749791579 (var2587) var696)
(declare-fun append/-1031950772 (String var2199) String)
(declare-fun cast-from-var696-to-var2199 (var696) var2199)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2587 var2587)
(declare-const var3568 var2587) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException 
(assert (not (= var3568 null-var2587)))
(define-const var718 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var718)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var718!1 String)
(assert (= var718!1 ""))
(assert true)
(define-const var3458 String (append/672562846 var718!1 "HttpResultPayloadException{result=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("HttpResultPayloadException{result=") 
(declare-const var718!2 String)
(assert (= var718!2 (str.++ var718!1 "HttpResultPayloadException{result=")))
(define-const var3608 var696 (result/-749791579 var3568)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException: org.apache.dubbo.remoting.http12.HttpResult result> 
(assert true)
(define-const var666 String (append/-1031950772 var3458 (cast-from-var696-to-var2199 var3608))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var3458!1 String)
(assert (str.prefixof var3458 var3458!1))
(assert true)
(define-const var1080 String (append/-1166366385 var666 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var666!1 String)
(assert (str.prefixof var666 var666!1))
(assert true)
(define-const var3363 String (toString/-2075883882 var1080)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), result/-749791579=([org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException], org.apache.dubbo.remoting.http12.HttpResult), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var696-to-var2199=([org.apache.dubbo.remoting.http12.HttpResult], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2587=org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException, var3568=r1, var718=$r0, var3458=$r3, var696=org.apache.dubbo.remoting.http12.HttpResult, var3608=$r2, var2199=java.lang.Object, var666=$r4, var1080=$r5, var3363=$r6}
; {org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException=var2587, r1=var3568, $r0=var718, $r3=var3458, org.apache.dubbo.remoting.http12.HttpResult=var696, $r2=var3608, java.lang.Object=var2199, $r4=var666, $r5=var1080, $r6=var3363}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("HttpResultPayloadException{result=");	$r2 = r1.<org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException: org.apache.dubbo.remoting.http12.HttpResult result>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1