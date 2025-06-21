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

(declare-sort var2451 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getServiceInterface/-1311863806 (var2451) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/390664010 (var2451 String String Bool) void)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2451 var2451)
(declare-const var1961 var2451) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1961 null-var2451)))
(define-const var597 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var597)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var597!1 String)
(assert (= var597!1 ""))
(assert true)
(define-const var2993 String (getServiceInterface/-1311863806 var1961)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true)
;(assert (append/672562846 var597!1 var2993)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var597!2 String)
(assert (= var597!2 (str.++ var597!1 var2993)))
(assert true)
;(assert (append/390664010 var1961 var597!2 "version" (ite (= 1 0) true false))) ; Statement: specialinvoke r1.<org.apache.dubbo.common.URL: void append(java.lang.StringBuilder,java.lang.String,boolean)>($r0, "version", 0) 

(declare-const var1961!1 var2451)
(declare-const var597!3 String)
(declare-const var2882 String)
(declare-const var2893 Int)
(assert true)
;(assert (append/390664010 var1961!1 var597!3 "group" (ite (= 1 0) true false))) ; Statement: specialinvoke r1.<org.apache.dubbo.common.URL: void append(java.lang.StringBuilder,java.lang.String,boolean)>($r0, "group", 0) 

(declare-const var1961!2 var2451)
(declare-const var597!4 String)
(declare-const var2654 String)
(declare-const var2893!1 Int)
(assert true)
(define-const var2834 String (toString/-2075883882 var597!4)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/390664010=([org.apache.dubbo.common.URL, java.lang.StringBuilder, java.lang.String, boolean], void), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2451=org.apache.dubbo.common.URL, var1961=r1, var597=$r0, var2993=$r2, var2882="version", var2893=0, var2654="group", var2834=$r3}
; {org.apache.dubbo.common.URL=var2451, r1=var1961, $r0=var597, $r2=var2993, "version"=var2882, 0=var2893, "group"=var2654, $r3=var2834}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	specialinvoke r1.<org.apache.dubbo.common.URL: void append(java.lang.StringBuilder,java.lang.String,boolean)>($r0, "version", 0);	specialinvoke r1.<org.apache.dubbo.common.URL: void append(java.lang.StringBuilder,java.lang.String,boolean)>($r0, "group", 0);	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 1