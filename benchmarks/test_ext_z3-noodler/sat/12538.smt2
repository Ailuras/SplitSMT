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

(declare-sort var2720 0)
(declare-sort var3886 0)
(declare-sort var1539 0)
(declare-sort var889 0)
(declare-sort var2778 0)
(declare-sort var299 0)
(declare-sort var1918 0)
(declare-sort var998 0)
(declare-sort var118 0)
(declare-sort var814 0)
(declare-sort var815 0)
(declare-sort var3396 0)
(declare-sort var3771 0)
(declare-sort var1143 0)
(declare-sort var3708 0)
(declare-sort var1262 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3886_lineSeparator/-342590142 () String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun frameworkModel/-1415014413 (var2720) var1539)
(declare-fun getServiceRepository/-1841533664 (var1539) var889)
(declare-fun allProviderModels/-1449635932 (var889) var2778)
(declare-fun var1918_stream/-1288525013 (var1918) var299)
(declare-fun cast-from-var2778-to-var1918 (var2778) var1918)
(declare-fun var118_bootstrap$/-1730233468 () var998)
(declare-fun var814_comparing/-789310709 (var998) var814)
(declare-fun var299_sorted/412285068 (var299 var814) var299)
(declare-fun var3396_toList/714215649 () var815)
(declare-fun var299_collect/-2050842585 (var299 var815) var3771)
(declare-fun cast-from-var3771-to-var1918 (var3771) var1918)
(declare-fun var1143-init () var1143)
(declare-fun arr-var3708-init () (Array Int var3708))
(declare-fun var3708-init () var3708)
(declare-fun <init>/777921279 (var3708 var1262) void)
(declare-fun <init>/-426181584 (var1143 (Array Int var3708)) void)
(declare-fun arr-var3771-init () (Array Int var3771))
(declare-fun cast-from-String-to-var3771 (String) var3771)
(declare-fun addRow/1508513099 (var1143 (Array Int var3771)) var1143)
(declare-fun var1918_iterator/-1617794947 (var1918) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun rendering/1955347074 (var1143) String)
(declare-const null-var2720 var2720)
(declare-const var1262-MIDDLE var1262)
(declare-const null-__Array__Int__var3708__ (Array Int var3708))
(declare-const null-__Array__Int__var3771__ (Array Int var3771))
(declare-const var1975 var2720) ; Statement: r6 := @this: org.apache.dubbo.qos.command.impl.Ls 
(assert (not (= var1975 null-var2720)))
(define-const var514 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var514)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var514!1 String)
(assert (= var514!1 ""))
(define-const var20 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var20)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var20!1 String)
(assert (= var20!1 ""))
(assert true)
(define-const var2644 String (append/672562846 var20!1 "As Provider side:")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("As Provider side:") 
(declare-const var20!2 String)
(assert (= var20!2 (str.++ var20!1 "As Provider side:")))
(define-const var3929 String var3886_lineSeparator/-342590142) ; Statement: $r2 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>() 
(assert true)
(define-const var2159 String (append/672562846 var2644 var3929)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2644!1 String)
(assert (= var2644!1 (str.++ var2644 var3929)))
(assert true)
(define-const var1611 String (toString/-2075883882 var2159)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (append/672562846 var514!1 var1611)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var514!2 String)
(assert (= var514!2 (str.++ var514!1 var1611)))
(define-const var3785 var1539 (frameworkModel/-1415014413 var1975)) ; Statement: $r7 = r6.<org.apache.dubbo.qos.command.impl.Ls: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel> 
(assert true)
(define-const var2421 var889 (getServiceRepository/-1841533664 var3785)) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.FrameworkServiceRepository getServiceRepository()>() 
(assert true)
(define-const var3101 var2778 (allProviderModels/-1449635932 var2421)) ; Statement: r38 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.FrameworkServiceRepository: java.util.List allProviderModels()>() 
(define-const var2018 var299 (var1918_stream/-1288525013 (cast-from-var2778-to-var1918 var3101))) ; Statement: $r11 = interfaceinvoke r38.<java.util.Collection: java.util.stream.Stream stream()>() 
(define-const var1878 var998 var118_bootstrap$/-1730233468) ; Statement: $r9 = staticinvoke <org.apache.dubbo.qos.command.impl.Ls$getServiceKey__875: java.util.function.Function bootstrap$()>() 
(define-const var1418 var814 (var814_comparing/-789310709 var1878)) ; Statement: $r10 = staticinvoke <java.util.Comparator: java.util.Comparator comparing(java.util.function.Function)>($r9) 
(define-const var3698 var299 (var299_sorted/412285068 var2018 var1418)) ; Statement: $r13 = interfaceinvoke $r11.<java.util.stream.Stream: java.util.stream.Stream sorted(java.util.Comparator)>($r10) 
(define-const var2884 var815 var3396_toList/714215649) ; Statement: $r12 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>() 
(define-const var85 var3771 (var299_collect/-2050842585 var3698 var2884)) ; Statement: $r14 = interfaceinvoke $r13.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r12) 
(define-const var812 var1918 (cast-from-var3771-to-var1918 var85)) ; Statement: r39 = (java.util.Collection) $r14 
(define-const var393 var1143 var1143-init) ; Statement: $r15 = new org.apache.dubbo.qos.textui.TTable 
(define-const var2128 (Array Int var3708) arr-var3708-init) ; Statement: $r16 = newarray (org.apache.dubbo.qos.textui.TTable$ColumnDefine)[2] 
(define-const var2672 var3708 var3708-init) ; Statement: $r17 = new org.apache.dubbo.qos.textui.TTable$ColumnDefine 
(define-const var3834 var1262 var1262-MIDDLE) ; Statement: $r18 = <org.apache.dubbo.qos.textui.TTable$Align: org.apache.dubbo.qos.textui.TTable$Align MIDDLE> 
(assert true)
;(assert (<init>/777921279 var2672 var3834)) ; Statement: specialinvoke $r17.<org.apache.dubbo.qos.textui.TTable$ColumnDefine: void <init>(org.apache.dubbo.qos.textui.TTable$Align)>($r18) 

(declare-const var2672!1 var3708)
(declare-const var3834!1 var1262)
(declare-const var2128!1 (Array Int var3708))
(assert (not (= var2128!1 null-__Array__Int__var3708__)))
(assert (= (select var2128!1 0) var2672!1)) ; Statement: $r16[0] = $r17 
(define-const var2809 var3708 var3708-init) ; Statement: $r19 = new org.apache.dubbo.qos.textui.TTable$ColumnDefine 
(define-const var3589 var1262 var1262-MIDDLE) ; Statement: $r20 = <org.apache.dubbo.qos.textui.TTable$Align: org.apache.dubbo.qos.textui.TTable$Align MIDDLE> 
(assert true)
;(assert (<init>/777921279 var2809 var3589)) ; Statement: specialinvoke $r19.<org.apache.dubbo.qos.textui.TTable$ColumnDefine: void <init>(org.apache.dubbo.qos.textui.TTable$Align)>($r20) 

(declare-const var2809!1 var3708)
(declare-const var3589!1 var1262)
(declare-const var2128!2 (Array Int var3708))
(assert (not (= var2128!2 null-__Array__Int__var3708__)))
(assert (= (select var2128!2 1) var2809!1)) ; Statement: $r16[1] = $r19 
(assert true)
;(assert (<init>/-426181584 var393 var2128!2)) ; Statement: specialinvoke $r15.<org.apache.dubbo.qos.textui.TTable: void <init>(org.apache.dubbo.qos.textui.TTable$ColumnDefine[])>($r16) 

(declare-const var393!1 var1143)
(declare-const var2128!3 (Array Int var3708))
(define-const var1898 (Array Int var3771) arr-var3771-init) ; Statement: $r21 = newarray (java.lang.Object)[2] 
(declare-const var1898!1 (Array Int var3771))
(assert (not (= var1898!1 null-__Array__Int__var3771__)))
(assert (= (select var1898!1 0) (cast-from-String-to-var3771 "Provider Service Name"))) ; Statement: $r21[0] = "Provider Service Name" 
(declare-const var1898!2 (Array Int var3771))
(assert (not (= var1898!2 null-__Array__Int__var3771__)))
(assert (= (select var1898!2 1) (cast-from-String-to-var3771 "PUB"))) ; Statement: $r21[1] = "PUB" 
(assert true)
;(assert (addRow/1508513099 var393!1 var1898!2)) ; Statement: virtualinvoke $r15.<org.apache.dubbo.qos.textui.TTable: org.apache.dubbo.qos.textui.TTable addRow(java.lang.Object[])>($r21) 

(declare-const var393!2 var1143)
(declare-const var1898!3 (Array Int var3771))
(define-const var3057 Iterator (var1918_iterator/-1617794947 var812)) ; Statement: r22 = interfaceinvoke r39.<java.util.Collection: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var395 Bool (Iterator_hasNext/-1669924200 var3057)) ; Statement: $z0 = interfaceinvoke r22.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r23 = virtualinvoke $r15.<org.apache.dubbo.qos.textui.TTable: java.lang.String rendering()>() 
(assert (= (ite var395 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var959 String (rendering/1955347074 var393!2)) ; Statement: $r23 = virtualinvoke $r15.<org.apache.dubbo.qos.textui.TTable: java.lang.String rendering()>() 
(assert true)
;(assert (append/672562846 var514!2 var959)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23) 
(declare-const var514!3 String)
(assert (= var514!3 (str.++ var514!2 var959)))
(assert true)
(define-const var1631 String (toString/-2075883882 var514!3)) ; Statement: $r24 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r24 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3886_lineSeparator/-342590142=([], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), frameworkModel/-1415014413=([org.apache.dubbo.qos.command.impl.Ls], org.apache.dubbo.rpc.model.FrameworkModel), getServiceRepository/-1841533664=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.rpc.model.FrameworkServiceRepository), allProviderModels/-1449635932=([org.apache.dubbo.rpc.model.FrameworkServiceRepository], java.util.List), var1918_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var2778-to-var1918=([java.util.List], java.util.Collection), var118_bootstrap$/-1730233468=([], java.util.function.Function), var814_comparing/-789310709=([java.util.function.Function], java.util.Comparator), var299_sorted/412285068=([java.util.stream.Stream, java.util.Comparator], java.util.stream.Stream), var3396_toList/714215649=([], java.util.stream.Collector), var299_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var3771-to-var1918=([java.lang.Object], java.util.Collection), var1143-init=([], org.apache.dubbo.qos.textui.TTable), arr-var3708-init=([], org.apache.dubbo.qos.textui.TTable$ColumnDefine[]), var3708-init=([], org.apache.dubbo.qos.textui.TTable$ColumnDefine), <init>/777921279=([org.apache.dubbo.qos.textui.TTable$ColumnDefine, org.apache.dubbo.qos.textui.TTable$Align], void), <init>/-426181584=([org.apache.dubbo.qos.textui.TTable, org.apache.dubbo.qos.textui.TTable$ColumnDefine[]], void), arr-var3771-init=([], java.lang.Object[]), cast-from-String-to-var3771=([java.lang.String], java.lang.Object), addRow/1508513099=([org.apache.dubbo.qos.textui.TTable, java.lang.Object[]], org.apache.dubbo.qos.textui.TTable), var1918_iterator/-1617794947=([java.util.Collection], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), rendering/1955347074=([org.apache.dubbo.qos.textui.TTable], java.lang.String)}
; {var2720=org.apache.dubbo.qos.command.impl.Ls, var1975=r6, var514=$r0, var20=$r1, var2644=$r3, var3886=java.lang.System, var3929=$r2, var2159=$r4, var1611=$r5, var1539=org.apache.dubbo.rpc.model.FrameworkModel, var3785=$r7, var889=org.apache.dubbo.rpc.model.FrameworkServiceRepository, var2421=$r8, var2778=java.util.List, var3101=r38, var299=java.util.stream.Stream, var1918=java.util.Collection, var2018=$r11, var998=java.util.function.Function, var118=org.apache.dubbo.qos.command.impl.Ls$getServiceKey__875, var1878=$r9, var814=java.util.Comparator, var1418=$r10, var3698=$r13, var815=java.util.stream.Collector, var3396=java.util.stream.Collectors, var2884=$r12, var3771=java.lang.Object, var85=$r14, var812=r39, var1143=org.apache.dubbo.qos.textui.TTable, var393=$r15, var3708=org.apache.dubbo.qos.textui.TTable$ColumnDefine, var2128=$r16, var2672=$r17, var1262=org.apache.dubbo.qos.textui.TTable$Align, var3834=$r18, var2809=$r19, var3589=$r20, var1898=$r21, var3057=r22, var395=$z0, var959=$r23, var1631=$r24}
; {org.apache.dubbo.qos.command.impl.Ls=var2720, r6=var1975, $r0=var514, $r1=var20, $r3=var2644, java.lang.System=var3886, $r2=var3929, $r4=var2159, $r5=var1611, org.apache.dubbo.rpc.model.FrameworkModel=var1539, $r7=var3785, org.apache.dubbo.rpc.model.FrameworkServiceRepository=var889, $r8=var2421, java.util.List=var2778, r38=var3101, java.util.stream.Stream=var299, java.util.Collection=var1918, $r11=var2018, java.util.function.Function=var998, org.apache.dubbo.qos.command.impl.Ls$getServiceKey__875=var118, $r9=var1878, java.util.Comparator=var814, $r10=var1418, $r13=var3698, java.util.stream.Collector=var815, java.util.stream.Collectors=var3396, $r12=var2884, java.lang.Object=var3771, $r14=var85, r39=var812, org.apache.dubbo.qos.textui.TTable=var1143, $r15=var393, org.apache.dubbo.qos.textui.TTable$ColumnDefine=var3708, $r16=var2128, $r17=var2672, org.apache.dubbo.qos.textui.TTable$Align=var1262, $r18=var3834, $r19=var2809, $r20=var3589, $r21=var1898, r22=var3057, $z0=var395, $r23=var959, $r24=var1631}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r6 := @this: org.apache.dubbo.qos.command.impl.Ls;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("As Provider side:");	$r2 = staticinvoke <java.lang.System: java.lang.String lineSeparator()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r7 = r6.<org.apache.dubbo.qos.command.impl.Ls: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel>;	$r8 = virtualinvoke $r7.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.FrameworkServiceRepository getServiceRepository()>();	r38 = virtualinvoke $r8.<org.apache.dubbo.rpc.model.FrameworkServiceRepository: java.util.List allProviderModels()>();	$r11 = interfaceinvoke r38.<java.util.Collection: java.util.stream.Stream stream()>();	$r9 = staticinvoke <org.apache.dubbo.qos.command.impl.Ls$getServiceKey__875: java.util.function.Function bootstrap$()>();	$r10 = staticinvoke <java.util.Comparator: java.util.Comparator comparing(java.util.function.Function)>($r9);	$r13 = interfaceinvoke $r11.<java.util.stream.Stream: java.util.stream.Stream sorted(java.util.Comparator)>($r10);	$r12 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toList()>();	$r14 = interfaceinvoke $r13.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r12);	r39 = (java.util.Collection) $r14;	$r15 = new org.apache.dubbo.qos.textui.TTable;	$r16 = newarray (org.apache.dubbo.qos.textui.TTable$ColumnDefine)[2];	$r17 = new org.apache.dubbo.qos.textui.TTable$ColumnDefine;	$r18 = <org.apache.dubbo.qos.textui.TTable$Align: org.apache.dubbo.qos.textui.TTable$Align MIDDLE>;	specialinvoke $r17.<org.apache.dubbo.qos.textui.TTable$ColumnDefine: void <init>(org.apache.dubbo.qos.textui.TTable$Align)>($r18);	$r16[0] = $r17;	$r19 = new org.apache.dubbo.qos.textui.TTable$ColumnDefine;	$r20 = <org.apache.dubbo.qos.textui.TTable$Align: org.apache.dubbo.qos.textui.TTable$Align MIDDLE>;	specialinvoke $r19.<org.apache.dubbo.qos.textui.TTable$ColumnDefine: void <init>(org.apache.dubbo.qos.textui.TTable$Align)>($r20);	$r16[1] = $r19;	specialinvoke $r15.<org.apache.dubbo.qos.textui.TTable: void <init>(org.apache.dubbo.qos.textui.TTable$ColumnDefine[])>($r16);	$r21 = newarray (java.lang.Object)[2];	$r21[0] = "Provider Service Name";	$r21[1] = "PUB";	virtualinvoke $r15.<org.apache.dubbo.qos.textui.TTable: org.apache.dubbo.qos.textui.TTable addRow(java.lang.Object[])>($r21);	r22 = interfaceinvoke r39.<java.util.Collection: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r22.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r23 = virtualinvoke $r15.<org.apache.dubbo.qos.textui.TTable: java.lang.String rendering()>();	$r23 = virtualinvoke $r15.<org.apache.dubbo.qos.textui.TTable: java.lang.String rendering()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r23);	$r24 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r24
;block_num 3