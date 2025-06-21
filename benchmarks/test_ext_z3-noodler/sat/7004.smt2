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

(declare-sort var3935 0)
(declare-sort var1226 0)
(declare-sort var3042 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getLevelColor/1458409046 (var3935 var1226) String)
(declare-fun name/1633728430 (var3042) String)
(declare-fun cast-from-var1226-to-var3042 (var1226) var3042)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3935 var3935)
(declare-const null-var1226 var1226)
(declare-const var246 var3935) ; Statement: r1 := @this: com.alibaba.dubbo.container.page.pages.StatusPageHandler 
(assert (not (= var246 null-var3935)))
(declare-const var3975 var1226) ; Statement: r2 := @parameter0: org.apache.dubbo.common.status.Status$Level 
(assert (not (= var3975 null-var1226)))
(define-const var3665 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3665)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3665!1 String)
(assert (= var3665!1 ""))
(assert true)
(define-const var1122 String (append/672562846 var3665!1 "<font color=\u0022")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("<font color=\"") 
(declare-const var3665!2 String)
(assert (= var3665!2 (str.++ var3665!1 "<font color=\u0022")))
(assert true)
(define-const var1640 String (getLevelColor/1458409046 var246 var3975)) ; Statement: $r3 = specialinvoke r1.<com.alibaba.dubbo.container.page.pages.StatusPageHandler: java.lang.String getLevelColor(org.apache.dubbo.common.status.Status$Level)>(r2) 
(assert true)
(define-const var3781 String (append/672562846 var1122 var1640)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1122!1 String)
(assert (= var1122!1 (str.++ var1122 var1640)))
(assert true)
(define-const var1265 String (append/672562846 var3781 "\u0022>")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\">") 
(declare-const var3781!1 String)
(assert (= var3781!1 (str.++ var3781 "\u0022>")))
(assert true)
(define-const var77 String (name/1633728430 (cast-from-var1226-to-var3042 var3975))) ; Statement: $r6 = virtualinvoke r2.<org.apache.dubbo.common.status.Status$Level: java.lang.String name()>() 
(assert true)
(define-const var3732 String (append/672562846 var1265 var77)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1265!1 String)
(assert (= var1265!1 (str.++ var1265 var77)))
(assert true)
(define-const var2094 String (append/672562846 var3732 "</font>")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("</font>") 
(declare-const var3732!1 String)
(assert (= var3732!1 (str.++ var3732 "</font>")))
(assert true)
(define-const var1517 String (toString/-2075883882 var2094)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getLevelColor/1458409046=([com.alibaba.dubbo.container.page.pages.StatusPageHandler, org.apache.dubbo.common.status.Status$Level], java.lang.String), name/1633728430=([java.lang.Enum], java.lang.String), cast-from-var1226-to-var3042=([org.apache.dubbo.common.status.Status$Level], java.lang.Enum), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3935=com.alibaba.dubbo.container.page.pages.StatusPageHandler, var246=r1, var1226=org.apache.dubbo.common.status.Status$Level, var3975=r2, var3665=$r0, var1122=$r4, var1640=$r3, var3781=$r5, var1265=$r7, var3042=java.lang.Enum, var77=$r6, var3732=$r8, var2094=$r9, var1517=$r10}
; {com.alibaba.dubbo.container.page.pages.StatusPageHandler=var3935, r1=var246, org.apache.dubbo.common.status.Status$Level=var1226, r2=var3975, $r0=var3665, $r4=var1122, $r3=var1640, $r5=var3781, $r7=var1265, java.lang.Enum=var3042, $r6=var77, $r8=var3732, $r9=var2094, $r10=var1517}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: com.alibaba.dubbo.container.page.pages.StatusPageHandler;	r2 := @parameter0: org.apache.dubbo.common.status.Status$Level;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("<font color=\"");	$r3 = specialinvoke r1.<com.alibaba.dubbo.container.page.pages.StatusPageHandler: java.lang.String getLevelColor(org.apache.dubbo.common.status.Status$Level)>(r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\">");	$r6 = virtualinvoke r2.<org.apache.dubbo.common.status.Status$Level: java.lang.String name()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("</font>");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1