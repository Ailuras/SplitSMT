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

(declare-sort var356 0)
(declare-sort var2424 0)
(declare-sort var3051 0)
(declare-sort var1786 0)
(declare-sort var3179 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/646124437 (var1786 var3179) void)
(declare-fun cast-from-var356-to-var1786 (var356) var1786)
(declare-fun cast-from-String-to-var3179 (String) var3179)
(declare-fun key/601958768 (var356) String)
(declare-fun group/601958768 (var356) String)
(declare-fun content/601958768 (var356) String)
(declare-fun changeType/601958768 (var356) var3051)
(declare-const null-var356 var356)
(declare-const null-String String)
(declare-const null-var3051 var3051)
(declare-const var2067 var356) ; Statement: r0 := @this: org.apache.dubbo.common.config.configcenter.ConfigChangedEvent 
(assert (not (= var2067 null-var356)))
(declare-const var2768 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2768 null-String)))
(declare-const var14 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var14 null-String)))
(declare-const var1371 String) ; Statement: r8 := @parameter2: java.lang.String 
(assert (not (= var1371 null-String)))
(declare-const var3570 var3051) ; Statement: r9 := @parameter3: org.apache.dubbo.common.config.configcenter.ConfigChangeType 
(assert (not (= var3570 null-var3051)))
(define-const var2634 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2634)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2634!1 String)
(assert (= var2634!1 ""))
(assert true)
(define-const var594 String (append/672562846 var2634!1 var2768)) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2634!2 String)
(assert (= var2634!2 (str.++ var2634!1 var2768)))
(assert true)
(define-const var419 String (append/672562846 var594 ",")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var594!1 String)
(assert (= var594!1 (str.++ var594 ",")))
(assert true)
(define-const var1322 String (append/672562846 var419 var14)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var419!1 String)
(assert (= var419!1 (str.++ var419 var14)))
(assert true)
(define-const var228 String (toString/-2075883882 var1322)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/646124437 (cast-from-var356-to-var1786 var2067) (cast-from-String-to-var3179 var228))) ; Statement: specialinvoke r0.<java.util.EventObject: void <init>(java.lang.Object)>($r7) 

(declare-const var2067!1 var356)
(declare-const var228!1 String)
(declare-const var2067!2 var356)
(assert (not (= var2067!2 null-var356)))
(assert (= (key/601958768 var2067!2) var2768)) ; Statement: r0.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String key> = r2 
(declare-const var2067!3 var356)
(assert (not (= var2067!3 null-var356)))
(assert (= (group/601958768 var2067!3) var14)) ; Statement: r0.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String group> = r4 
(declare-const var2067!4 var356)
(assert (not (= var2067!4 null-var356)))
(assert (= (content/601958768 var2067!4) var1371)) ; Statement: r0.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String content> = r8 
(declare-const var2067!5 var356)
(assert (not (= var2067!5 null-var356)))
(assert (= (changeType/601958768 var2067!5) var3570)) ; Statement: r0.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: org.apache.dubbo.common.config.configcenter.ConfigChangeType changeType> = r9 
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/646124437=([java.util.EventObject, java.lang.Object], void), cast-from-var356-to-var1786=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], java.util.EventObject), cast-from-String-to-var3179=([java.lang.String], java.lang.Object), key/601958768=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], java.lang.String), group/601958768=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], java.lang.String), content/601958768=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], java.lang.String), changeType/601958768=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], org.apache.dubbo.common.config.configcenter.ConfigChangeType)}
; {var356=org.apache.dubbo.common.config.configcenter.ConfigChangedEvent, var2067=r0, var2768=r2, var2424=null_type, var14=r4, var1371=r8, var3051=org.apache.dubbo.common.config.configcenter.ConfigChangeType, var3570=r9, var2634=$r1, var594=$r3, var419=$r5, var1322=$r6, var228=$r7, var1786=java.util.EventObject, var3179=java.lang.Object}
; {org.apache.dubbo.common.config.configcenter.ConfigChangedEvent=var356, r0=var2067, r2=var2768, null_type=var2424, r4=var14, r8=var1371, org.apache.dubbo.common.config.configcenter.ConfigChangeType=var3051, r9=var3570, $r1=var2634, $r3=var594, $r5=var419, $r6=var1322, $r7=var228, java.util.EventObject=var1786, java.lang.Object=var3179}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.config.configcenter.ConfigChangedEvent;	r2 := @parameter0: java.lang.String;	r4 := @parameter1: java.lang.String;	r8 := @parameter2: java.lang.String;	r9 := @parameter3: org.apache.dubbo.common.config.configcenter.ConfigChangeType;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke r0.<java.util.EventObject: void <init>(java.lang.Object)>($r7);	r0.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String key> = r2;	r0.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String group> = r4;	r0.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String content> = r8;	r0.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: org.apache.dubbo.common.config.configcenter.ConfigChangeType changeType> = r9;	return
;block_num 1