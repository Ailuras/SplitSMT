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

(declare-sort var1497 0)
(declare-sort var2878 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/506106603 (var1497 String String) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getAddress/-2093578336 (var1497) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun addParameter/-1629709269 (var1497 String String) var1497)
(declare-const null-var1497 var1497)
(declare-const null-String String)
(declare-const var1741 var1497) ; Statement: r6 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1741 null-var1497)))
(declare-const var1972 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1972 null-String)))
(assert true)
(define-const var2124 String (getParameter/506106603 var1741 "threadname" var1972)) ; Statement: r7 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("threadname", r0) 
(define-const var1996 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1996)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1996!1 String)
(assert (= var1996!1 ""))
(assert true)
(define-const var3637 String (append/672562846 var1996!1 var2124)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var1996!2 String)
(assert (= var1996!2 (str.++ var1996!1 var2124)))
(assert true)
(define-const var1819 String (append/672562846 var3637 "-")) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var3637!1 String)
(assert (= var3637!1 (str.++ var3637 "-")))
(assert true)
(define-const var1024 String (getAddress/-2093578336 var1741)) ; Statement: $r3 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(assert true)
(define-const var3236 String (append/672562846 var1819 var1024)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1819!1 String)
(assert (= var1819!1 (str.++ var1819 var1024)))
(assert true)
(define-const var2773 String (toString/-2075883882 var3236)) ; Statement: r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var3199 var1497 (addParameter/-1629709269 var1741 "threadname" var2773)) ; Statement: r9 = virtualinvoke r6.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("threadname", r8) 
 ; Statement: return r9 
(check-sat)
; {getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL)}
; {var1497=org.apache.dubbo.common.URL, var1741=r6, var1972=r0, var2878=null_type, var2124=r7, var1996=$r1, var3637=$r2, var1819=$r4, var1024=$r3, var3236=$r5, var2773=r8, var3199=r9}
; {org.apache.dubbo.common.URL=var1497, r6=var1741, r0=var1972, null_type=var2878, r7=var2124, $r1=var1996, $r2=var3637, $r4=var1819, $r3=var1024, $r5=var3236, r8=var2773, r9=var3199}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @parameter0: org.apache.dubbo.common.URL;	r0 := @parameter1: java.lang.String;	r7 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("threadname", r0);	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$r3 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	r9 = virtualinvoke r6.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("threadname", r8);	return r9
;block_num 1